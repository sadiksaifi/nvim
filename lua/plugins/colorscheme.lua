-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   priority = 100,
--   lazy = false,
--   config = function()
--     require("rose-pine").setup {
--       dark_variant = "main", -- main, moon, or dawn
--       styles = {
--         bold = true,
--         italic = true,
--         transparency = false,
--       },
--     }
--
--     vim.cmd.colorscheme "rose-pine"
--   end,
-- }
return {
  "mofiqul/vscode.nvim",
  priority = 100,
  lazy = false,
  config = function()
    require("vscode").setup {
			style="light"
    }

    vim.cmd.colorscheme "vscode"
  end,
}
