return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- float = {
        -- 	-- transparent = true,
        -- 	-- solid = false,
        -- },
        integrations = {
          diffview = true,
          fidget = true,
          harpoon = true,
          mason = true,
          native_lsp = { enabled = true },
          snacks = {
            enabled = true,
            indent_scope_color = "mauve",
          },
          render_markdown = true,
          treesitter = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
