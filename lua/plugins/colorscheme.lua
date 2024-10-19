return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 100,
  lazy = false,
  config = function()
    require("rose-pine").setup {
      dark_variant = "main", -- main, moon, or dawn
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    }

    vim.cmd.colorscheme "rose-pine"
  end,
}
