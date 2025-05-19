return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	keys = {
		{
			"<leader>lf",
			"<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
			desc = "Format",
		},
	},
	config = function()
		require("mason-null-ls").setup {
			automatic_setup = true,
			ensure_installed = require("user.languages").fmtNLint,
			automatic_installation = true,
		}
	end,
}
