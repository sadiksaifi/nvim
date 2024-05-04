-- return {
--   "askfiy/visual_studio_code",
--   priority = 100,
--   config = function()
--     require("visual_studio_code").setup({
--       transparent = true,
--     })
--
--     vim.cmd("colorscheme visual_studio_code")
--   end,
-- }
return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      transparent_mode = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
    })

    vim.cmd("colorscheme gruvbox")
  end,
-- #1c2021
}
