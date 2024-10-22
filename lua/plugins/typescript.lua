return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "typescript.tsx" },
  keys = {
    { "<leader>lR", vim.cmd.TSToolsRenameFile, desc = "Typescript Rename File" },
    { "<leader>ru", vim.cmd.TSToolsRemoveUnusedImports, desc = "Typescript Remove Unused" },
  },
  config = function()
    require("typescript-tools").setup {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }
  end,
}
