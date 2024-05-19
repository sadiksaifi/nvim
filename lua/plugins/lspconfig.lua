return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "folke/neodev.nvim",
  config = function()
    local lspconfig = require "lspconfig"

    -- diagnostic config
    vim.diagnostic.config({
      virtual_text = true,
      update_in_insert = false,
      underline = true,
    })

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set
      keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
      keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "gl", vim.diagnostic.open_float, opts)
      keymap("n", "]d", vim.diagnostic.goto_next, opts)
      keymap("n", "[d", vim.diagnostic.goto_prev, opts)
      keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
      keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
    end

    local common_capabilities = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      return capabilities
    end

    local servers = require("user.languages").servers
    for _, server in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = common_capabilities(),
      }

      local require_ok, settings = pcall(require, "user.lspsettings." .. server)
      if require_ok then
        opts = vim.tbl_deep_extend("force", settings, opts)
      end

      if server == "lua_ls" then
        require("neodev").setup {}
      end

      lspconfig[server].setup(opts)
    end
  end,
}
