return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/typescript.nvim",
	},
	config = function()
		-- Using protected call
		local lsp_ok, lspconfig = pcall(require, "lspconfig")
		if not lsp_ok then
			return
		end
		local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if not cmp_nvim_lsp_ok then
			return
		end
		local typescript_ok, typescript = pcall(require, "typescript")
		if not typescript_ok then
			return
		end

    -- Setting up icons for diagnostics
    local signs = { Error = "✘ ", Warn = "▲ ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

		-- Setting up capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Setting up on_attach
		local on_attach = function(client, bufnr)
			local opts = { silent = true, buffer = bufnr }

      -- Setting keymaps for lsp
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "dl", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "d]", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "d[", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
			vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts)

      -- Typescript specific settings
      if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
        vim.keymap.set("n", "<leader>lR", vim.cmd.TypescriptRenameFile, opts)
      end
		end

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
				},
			},
		})

		-- Setting up ts server
    typescript.setup({
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
      },
    })

		-- Setting up html server
		lspconfig.html.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

    -- Setting up css server
    lspconfig.cssls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Setting up eslint server
    lspconfig.eslint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Setting up json server
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Setting up bash server
    lspconfig.bashls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

	end,
}
