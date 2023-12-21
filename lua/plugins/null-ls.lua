return {
	"jay-babu/mason-null-ls.nvim",
	event = "BufReadPre",
	opts = {
		automatic_setup = true,
		ensure_installed = require("utils").linters,
		automatic_installation = true,
	},
	dependencies = {
		{
			"jose-elias-alvarez/null-ls.nvim",
			dependencies = "nvim-lua/plenary.nvim",
			keys = {
				{
					"<leader>lf",
					"<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
					desc = "Format",
				},
				{ "<leader>ln", "<cmd>NullLsInfo<cr>", desc = "NullLsInfo" },
			},
			config = function()
				-- Using protected call
				local null_ls = require("null-ls")
				local formatting = null_ls.builtins.formatting
				local diagnostics = null_ls.builtins.diagnostics

				-- Setting up null ls
				null_ls.setup({
					debug = false,
					sources = {
						formatting.prettier,
						formatting.stylua,
					},
				})
			end,
		},
	},
}
