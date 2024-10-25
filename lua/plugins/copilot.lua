return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup {
      keymaps = {
        accept_suggestion = "<C-l>",
        clear_suggestion = "<C-h>",
        accept_word = "<C-j>",
      }
      -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
    }
  end,
}
