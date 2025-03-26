return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "folke/neodev.nvim",
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
      keymap("n", "gI", vim.lsp.buf.implementation, opts)
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

    -- Ui stuff
    local default_diagnostic_config = {
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = "" },
          { name = "DiagnosticSignWarn", text = "" },
          { name = "DiagnosticSignHint", text = "" },
          { name = "DiagnosticSignInfo", text = "" },
        },
      },
      virtual_text = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
