return {
  'nvim-telescope/telescope.nvim', version = '0.1.1',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()
    -- Using protected call
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
      return
    end

    -- Configuration
    local actions = require "telescope.actions"
    telescope.setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", ".idea" },
      },
    }

    -- Setting Telescope Keymaps
    local keymap = vim.keymap.set
    local opts = { silent = true }
    keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
    keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
    keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
    keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
    keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
    keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
  end
}
