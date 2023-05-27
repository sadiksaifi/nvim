return {
	"williamboman/mason.nvim",
	keys = {
		{ "<leader>lI", "<cmd>Mason<CR>", desc = "Opens Mason" },
	},
	-- build = function()
	-- 	pcall(vim.cmd, "MasonUpdate") -- TODO: disable lua_ls warning
	-- end,
	cmd = "Mason",
  lazy = true,
	opts = {
		ui = {
			border = "rounded",
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		log_level = vim.log.levels.INFO,
		max_concurrent_installers = 4,
	},
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
      event = "BufWinEnter",
			opts = {
        ensure_installed = require("utils").servers,
				automatic_installation = true,
			},
		},
		{
			"jay-babu/mason-null-ls.nvim",
      event = "VeryLazy",
      after = "Mason",
			opts = {
				automatic_setup = true,
				ensure_installed = require("utils").linters,
				automatic_installation = true,
			},
		},
	},
}
