return {
	{
		"mason-org/mason.nvim",
		event = { "BufReadPre", "BufNewFile", "BufEnter" },
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = { ensure_installed = require("user.languages").server_names },
		},
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile", "BufEnter" },
		config = function()
			-- diagnostic config
			vim.diagnostic.config {
				virtual_text = true,
				update_in_insert = true,
				underline = true,
			}

			for _, server in ipairs(require("user.languages").servers) do
				vim.lsp.enable(server)
			end

			local on_attach = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local keymap = function(keys, func)
					vim.keymap.set("n", keys, func, { buffer = args.buf })
				end

				keymap("gd", vim.lsp.buf.definition)
				keymap("gr", vim.lsp.buf.references)
				keymap("gl", vim.diagnostic.open_float)
				keymap("<leader>la", vim.lsp.buf.code_action)
				keymap("<leader>lr", vim.lsp.buf.rename)

				-- TypeScript-specific keymap
				if client and (client.name == "vtsls" or client.name == "tsserver") then
					keymap("gl", "<cmd>PrettyTsError<cr>")
				end
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = on_attach,
			})
		end,
	},
}
