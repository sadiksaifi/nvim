return {
  "jose-elias-alvarez/typescript.nvim",
  ft = { "typescript", "typescriptreact", "typescript.tsx" },
  keys = {
    { "<leader>lR", vim.cmd.TypescriptRenameFile, desc="" },
    { "<leader>oi", vim.cmd.TypescriptOrganizeImports, desc="" },
    { "<leader>ai", vim.cmd.TypescriptAddImport, desc="" },
    { "<leader>ru", vim.cmd.TypescriptRemoveUnused, desc="" },
  },
  opts = {
    server = {
      on_attach = On_attach,
      capabilities = Capabilities,
    },
  },
}