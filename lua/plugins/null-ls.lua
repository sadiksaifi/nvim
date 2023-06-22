return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = {
    { "nvim-lua/plenary.nvim" },
		{
			"jay-babu/mason-null-ls.nvim",
			opts = {
				automatic_setup = true,
				ensure_installed = require("utils").linters,
				automatic_installation = true,
			},
		},
	},
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
		local null_ls_status_ok, null_ls = pcall(require, "null-ls")
		if not null_ls_status_ok then
			return
		end

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		-- Setting up null ls
		null_ls.setup({
      border = "rounded",
			debug = false,
			sources = {
				formatting.prettier.with({
					extra_filetypes = { "toml" },
					extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
				}),
				formatting.black.with({ extra_args = { "--fast" } }),
				formatting.stylua,
				formatting.google_java_format,
				diagnostics.flake8,
			},
		})
	end,
}
