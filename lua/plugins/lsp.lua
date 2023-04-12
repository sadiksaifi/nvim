return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },
    {
      "williamboman/mason.nvim",
      build = function()
        pcall(vim.cmd, "MasonUpdate")
      end,
    },
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
  },
  config = function()
    local lsp = require("lsp-zero").preset({
      manage_nvim_cmp = {
        set_sources = "recommended",
      },
    })

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({ buffer = bufnr })
      local bind = vim.keymap.set

      -- Setting keymaps
      bind("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
      bind("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      bind("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
      bind("n", "<leader>lI", "<cmd>Mason<cr>", opts)
    end)

    lsp.ensure_installed({
      "lua_ls",
      "cssls",
      "html",
      "tsserver",
      "bashls",
      "jsonls",
      "tailwindcss",
    })

    lsp.set_sign_icons({
      error = "✘",
      warn = "▲",
      hint = "⚑",
      info = "»",
    })

    -- Disable some default keymaps
    lsp.default_keymaps({
      buffer = bufnr,
      omit = { "gl", "K" },
    })

    --lsp.nvim_lua_ls({

    --})

    lsp.setup()

    -- Setting up cmp
    local cmp = require("cmp")

    cmp.setup({
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = "λ",
            luasnip = "⋗",
            buffer = "Ω",
            path = "🖫",
            nvim_lua = "Π",
          }

          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },
    })
  end,
}
