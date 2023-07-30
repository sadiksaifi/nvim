return {
  "jose-elias-alvarez/typescript.nvim",
  ft = { "typescript", "typescriptreact", "typescript.tsx" },
  keys = {
    { "<leader>lR", vim.cmd.TypescriptRenameFile, desc="" },
    { "<leader>oi", vim.cmd.TypescriptOrganizeImports, desc="" },
    { "<leader>ai", vim.cmd.TypescriptAddMissingImports, desc="" },
    { "<leader>ru", vim.cmd.TypescriptRemoveUnused, desc="" },
  },
  opts = {
    server = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    },
  },
}
