return {
  "askfiy/visual_studio_code",
  priority = 100,
  config = function()
    require("visual_studio_code").setup({
      transparent = true,
    })

    vim.cmd("colorscheme visual_studio_code")
  end,
}
