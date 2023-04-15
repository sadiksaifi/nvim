return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
    lazy = true,
	},
  build = function()
    pcall(vim.cmd, "MasonUpdate") -- TODO: disable lua_ls warning
  end,
	cmd = "Mason",
	event = "BufReadPre",
	config = function()
		-- Using protected call
		local mason_ok, mason = pcall(require, "mason")
		if not mason_ok then
			return
		end
		local mason_lspcfg_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
		if not mason_lspcfg_ok then
			return
		end

		-- Seeting up Mason
		mason.setup({
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
		})
		--
		-- -- Setting up Mason LSP Bridge
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"cssls",
				"html",
				"tsserver",
				"eslint",
				"bashls",
				"jsonls",
			},
			automatic_installation = true,
		})

    -- Setting up keymaps
    vim.keymap.set("n", "<leader>lI", vim.cmd.Mason, { silent = true })
	end,
}
