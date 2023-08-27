return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		event = "BufReadPre",
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Setting up on_attach
			local on_attach = function(client, bufnr)
				local opts = { silent = true, buffer = bufnr }

				-- Setting keymaps for lsp
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)
				vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts)

				-- Typescript specific settings
				if client.name == "tsserver" then
					client.server_capabilities.documentFormattingProvider = false
				end

				-- Eslint specific settings
				if client.name == "eslint" then
					vim.keymap.set("n", "<leader>le", vim.cmd.EslintFixAll, opts)
				end
			end

			-- Setting up servers
			for _, server in pairs(require("utils").servers) do
				Opts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				server = vim.split(server, "@")[1]
				lspconfig[server].setup(Opts)
			end

			-- Setting up border for LspInfo
			require("lspconfig.ui.windows").default_options.border = "rounded"

			-- Setting up icons for diagnostics
			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "󰋽" },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					active = signs,
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
					suffix = "",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})
			-- Setting up lua server
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},
}
