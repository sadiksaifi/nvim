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

				-- TypeScript-specific keymap
				if client and (client.name == "vtsls" or client.name == "tsserver") then
					vim.keymap.set("n", "<C-w>D", "<cmd>PrettyTsError<cr>", { buffer = args.buf })
					vim.api.nvim_buf_create_user_command(args.buf, "OrganizeImports", function()
						vim.lsp.buf.code_action {
							context = { only = { "source.organizeImports" }, diagnostics = {} },
							apply = true,
						}
					end, { desc = "Organize imports using vtsls" })
				end
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = on_attach,
			})
		end,
	},
}
