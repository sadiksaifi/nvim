return {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>ft", "<cmd>Telescope live_grep<CR>",  desc = "Find a string" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Help" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>",    desc = "Find keymaps" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules", ".idea" },
    },
  },
}
