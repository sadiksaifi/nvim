return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "typescript.tsx" },
  keys = {
    { "<leader>lR", vim.cmd.TSToolsRenameFile, desc = "Typescript Rename File" },
    { "<leader>ru", vim.cmd.TSToolsRemoveUnusedImports, desc = "Typescript Remove Unused" },
  },
  opts = {},
}
