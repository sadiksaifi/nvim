return {
  "LunarVim/darkplus.nvim",
  priority = 100,
  config = function()
    local code = require "darkplus"
    code.setup {
      transparent = true,
    }

    vim.cmd "colorscheme darkplus"
  end,
}
