return {
  "askfiy/visual_studio_code",
  priority = 100,
  config = function()
    local code = require "visual_studio_code"
    code.setup {
      transparent = true,
    }

    vim.cmd "colorscheme visual_studio_code"
  end,
}
