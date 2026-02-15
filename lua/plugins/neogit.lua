return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required

    -- Only one of these is needed.
    "sindrets/diffview.nvim", -- optional

    -- Only one of these is needed.
    "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>G", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
}
