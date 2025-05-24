local M = {
  { "stevearc/dressing.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "Telescope",
    event = { "LspAttach" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>ft", "<cmd>Telescope live_grep<CR>", desc = "Find a string" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
      { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    },
    config = function()
      local telescope = require "telescope"
      telescope.setup {
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
        defaults = {
          file_ignore_patterns = { "node_modules/", ".yarn/", ".git/", ".idea/" },
        },
      }
    end,
  },
}

return M
