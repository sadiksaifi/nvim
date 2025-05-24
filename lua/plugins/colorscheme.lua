return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup {
      dark_variant = "main",
      styles = {
        transparency = true,
      },
    }

    vim.cmd "colorscheme rose-pine"
  end,
}
