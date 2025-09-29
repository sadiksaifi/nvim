local M = {
  {
    "mason-org/mason.nvim",
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = { ensure_installed = require("user.languages").servers },
    },
    event = { "BufEnter" },
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
      -- diagnostic config
      vim.diagnostic.config {
        virtual_text = true,
        update_in_insert = false,
        underline = true,
      }

      local servers = require("user.languages").servers
      vim.lsp.enable(servers)

      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)
        keymap("n", "gl", vim.diagnostic.open_float, opts)
        keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = on_attach,
      })
    end,
  },
}

return M
