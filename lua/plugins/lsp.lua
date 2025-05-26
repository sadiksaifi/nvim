local M = {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  opts = {
    ---@type string[]
    ensure_installed = require("user.languages").servers,

    ---@type boolean | string[] | { exclude: string[] }
    automatic_enable = false,
  },
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
    {
      "mason-org/mason.nvim",
      event = { "BufEnter" },
      opts = {
        ui = {
          border = "rounded",
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require "lspconfig"

        -- diagnostic config
        vim.diagnostic.config {
          virtual_text = true,
          update_in_insert = false,
          underline = true,
        }

        local on_attach = function(_, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          local keymap = vim.keymap.set
          keymap("n", "gd", vim.lsp.buf.definition, opts)
          keymap("n", "gD", vim.lsp.buf.declaration, opts)
          keymap("n", "gr", vim.lsp.buf.references, opts)
          keymap("n", "K", function()
            vim.lsp.buf.hover { border = "single" }
          end, opts)
          keymap("n", "gl", vim.diagnostic.open_float, opts)
          keymap("n", "gL", function()
            vim.cmd.compiler "tsc"
            vim.opt_local.makeprg = "tsc --noEmit"
            vim.cmd("silent! make")
						vim.cmd.copen()
          end, opts)
          keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
          keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
        end
        local common_capabilities = function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          return capabilities
        end

        local opts = {
          on_attach = on_attach,
          capabilities = common_capabilities(),
        }

        local servers = require("user.languages").servers
        for _, server in pairs(servers) do
          local require_ok, settings = pcall(require, "user.lspsettings." .. server)
          if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
          end

          lspconfig[server].setup(opts)
        end
      end,
    },
  },
}

return M
