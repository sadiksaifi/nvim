return {
	"iamcco/markdown-preview.nvim",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
  ft = { "markdown", "md"},
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "Markdown Preview" },
	},
	config = function()
		vim.g.mkdp_theme = "light"
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
	end,
}
