return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    -- Using protected call
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
      return
    end
    local _, mason_null_ls = pcall(require, "mason-null-ls")
    if not _ then
      return
    end

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    -- Setting mason null ls
    mason_null_ls.setup({
      automatic_setup = true,
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
      },
      automatic_installation = false,
    })

    -- Setting up null ls
    null_ls.setup({
      debug = false,
      sources = {
        formatting.prettier.with({
          extra_filetypes = { "toml" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        formatting.google_java_format,
        diagnostics.flake8,
      },
    })

    -- Setting keymap
    vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { silent = true })
  end,
}
