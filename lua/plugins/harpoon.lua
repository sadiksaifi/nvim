return {
  "sadiksaifi/harpoon",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  config = function ()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<s-m>", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
    keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
  end
}
