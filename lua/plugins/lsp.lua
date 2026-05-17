return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim" },
        { path = "lazy.nvim" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile", "BufEnter" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
      -- LSP installer plugins
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Lua LSP type definitions
      "folke/lazydev.nvim",
      -- Progress indicator for LSP
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 100,
            },
          },
        },
      },
    },
    config = function()

      -- List your LSP servers here.
      local servers = {
        bashls = {},
        biome = {},
        -- vtsls = {},
        tsgo = {},
        cssls = {},
        eslint = {
          autostart = false,
          cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
          settings = { format = false },
        },
        html = {},
        jsonls = {
          settings = {
            json = {
              validate = { enable = true },
              format = { enable = false },
            },
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              -- jsonls reports JSONC trailing commas/comments as parser diagnostics
              -- (codes 519/521). Keep schema diagnostics, but drop these false positives.
              if result and result.diagnostics then
                local bufnr = vim.uri_to_bufnr(result.uri)
                if vim.bo[bufnr].filetype == "jsonc" then
                  result.diagnostics = vim.tbl_filter(function(diagnostic)
                    local code = tostring(diagnostic.code or "")
                    return code ~= "519" and code ~= "521"
                  end, result.diagnostics)
                end
              end

              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
            ["textDocument/diagnostic"] = function(err, result, ctx, config)
              -- Nvim 0.12 uses LSP pull diagnostics for jsonls, so filter there too.
              if result and result.items and ctx.bufnr and vim.bo[ctx.bufnr].filetype == "jsonc" then
                result.items = vim.tbl_filter(function(diagnostic)
                  local code = tostring(diagnostic.code or "")
                  return code ~= "519" and code ~= "521"
                end, result.items)
              end

              vim.lsp.diagnostic.on_diagnostic(err, result, ctx, config)
            end,
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
        marksman = {},
        oxlint = {
          root_markers = { ".oxlintrc.json" },
        },
        sqls = {},
        tailwindcss = {
          filetypes = { "typescriptreact", "javascriptreact", "html", "svelte", "astro" },
        },
        yamlls = {},
        svelte = {},
        astro = {},
        gopls = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy", features = "all" },
            },
          },
        },
      }

      local formatters = {
        prettierd = {},
        oxfmt = {},
        stylua = {},
      }

      local manually_installed_servers = { "ocamllsp" }
      local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))
      local ensure_installed = vim.tbl_filter(function(name)
        return not vim.tbl_contains(manually_installed_servers, name)
      end, mason_tools_to_install)

      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        ensure_installed = ensure_installed,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Use Blink.cmp capabilities if available, fallback to cmp_nvim_lsp
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink then
        capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
      else
        local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
        if has_cmp then
          capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
        end
      end

      -- Setup LspAttach autocmd for keybindings (replaces on_attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local bufname = vim.api.nvim_buf_get_name(bufnr)

          -- Detach from non-file buffers (diffview, fugitive, etc.)
          if bufname == "" or bufname:match("^diffview://") or bufname:match("^fugitive://") then
            vim.schedule(function()
              vim.lsp.buf_detach_client(bufnr, event.data.client_id)
            end)
            return
          end

          -- map_lsp_keybinds(bufnr)
        end,
      })

      -- Setup each LSP server using the new vim.lsp.config API
      for name, config in pairs(servers) do
        local server_capabilities = capabilities

        -- tsgo currently registers a watcher for the virtual URI
        -- `bundled:///libs/**/*`, which Neovim 0.12 rejects as a filesystem glob.
        if name == "tsgo" then
          server_capabilities = vim.deepcopy(capabilities)
          server_capabilities.workspace = server_capabilities.workspace or {}
          server_capabilities.workspace.didChangeWatchedFiles = {
            dynamicRegistration = false,
          }
        end

        -- Configure the server
        vim.lsp.config(name, {
          cmd = config.cmd,
          capabilities = server_capabilities,
          filetypes = config.filetypes,
          settings = config.settings,
          handlers = config.handlers,
          root_dir = config.root_dir,
          root_markers = config.root_markers,
        })

        -- Enable the server (with autostart setting if specified)
        if config.autostart == false then
          -- Don't auto-enable servers with autostart = false
          -- Users can manually enable with :lua vim.lsp.enable(name)
        else
          vim.lsp.enable(name)
        end
      end

      -- Biome for JSON linting in non-biome projects (trailing commas, etc.)
      -- Regular biome (from servers table) handles biome-configured projects.
      vim.lsp.config("biome_json", {
        cmd = { "biome", "lsp-proxy" },
        capabilities = capabilities,
        filetypes = { "json", "jsonc" },
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local has_biome_config = vim.fs.find({ "biome.json", "biome.jsonc" }, {
            path = fname,
            upward = true,
            stop = vim.uv.os_homedir(),
          })[1]
          if has_biome_config then
            return
          end
          on_dir(vim.fn.fnamemodify(fname, ":h"))
        end,
      })
      vim.lsp.enable("biome_json")

      -- Setup Mason for managing external LSP servers
      require("mason").setup({ ui = { border = "rounded" } })
      require("mason-lspconfig").setup()
    end,
  },
}
