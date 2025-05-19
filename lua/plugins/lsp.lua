local M = {
	"mason-org/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile", "BufEnter" },
	opts = {
		---@type string[]
		ensure_installed = require("user.languages").servers,

		---@type boolean | string[] | { exclude: string[] }
		automatic_enable = true,
	},
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		{
			"mason-org/mason.nvim",
			event = { "BufEnter" },
			opts = {
				ui = {
					border = "rounded",
				},
			}
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				local lspconfig = require "lspconfig"

				-- diagnostic config
				vim.diagnostic.config {
					virtual_text = true,
					update_in_insert = false,
					underline = true,
				}

				local on_attach = function(_, bufnr)
					local opts = { noremap = true, silent = true, buffer = bufnr }
					local keymap = vim.keymap.set
					keymap("n", "gd", function()
						vim.lsp.buf.definition {
							on_list = function(options)
								-- custom logic to avoid showing multiple definition when you use this style of code:
								-- `local M.my_fn_name = function() ... end`.
								-- See also post here: https://www.reddit.com/r/neovim/comments/19cvgtp/any_way_to_remove_redundant_definition_in_lua_file/

								-- vim.print(options.items)
								local unique_defs = {}
								local def_loc_hash = {}

								-- each item in options.items contain the location info for a definition provided by LSP server
								for _, def_location in pairs(options.items) do
									-- use filename and line number to uniquelly indentify a definition,
									-- we do not expect/want multiple definition in single line!
									local hash_key = def_location.filename .. def_location.lnum

									if not def_loc_hash[hash_key] then
										def_loc_hash[hash_key] = true
										table.insert(unique_defs, def_location)
									end
								end

								options.items = unique_defs

								-- set the location list
								---@diagnostic disable-next-line: param-type-mismatch
								vim.fn.setloclist(0, {}, " ", options)

								-- open the location list when we have more than 1 definitions found,
								-- otherwise, jump directly to the definition
								if #options.items > 1 then
									vim.cmd.lopen()
								else
									vim.cmd [[silent! lfirst]]
								end
							end,
						}
					end, opts)
					keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
					keymap("n", "K", function()
						vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
					end, opts)
					keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					keymap("n", "gl", vim.diagnostic.open_float, opts)
					keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
					keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
				end
				local common_capabilities = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.completion.completionItem.snippetSupport = true
					return capabilities
				end

				local servers = require("user.languages").servers
				for _, server in pairs(servers) do
					local opts = {
						on_attach = on_attach,
						capabilities = common_capabilities(),
					}

					lspconfig[server].setup(opts)
				end
			end,
		},
	},
}

return M
