return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				local formatting = null_ls.builtins.formatting
				-- local diagnostics = null_ls.builtins.diagnostics
				null_ls.setup({
					debug = false,
					sources = {
						formatting.prettier,
						formatting.stylua,
					},
				})
			end
		},
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
