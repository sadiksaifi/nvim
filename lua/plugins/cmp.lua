return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp",
    },
		{
			"hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = "rafamadriz/friendly-snippets",
		},
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{
			"roobert/tailwindcss-colorizer-cmp.nvim",
			-- optionally, override the default options:
			config = function()
				require("tailwindcss-colorizer-cmp").setup({
					color_square_width = 2,
				})
			end,
		},
	},
	event = "InsertEnter",
	config = function()
		-- Using protected call
		local cmp_ok, cmp = pcall(require, "cmp")
		if not cmp_ok then
			return
		end
		local luasnip_ok, luasnip = pcall(require, "luasnip")
		if not luasnip_ok then
			return
		end
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				fields = { "menu", "abbr", "kind" },
				format = function(entry, item)
					local menu_icon = {
						nvim_lsp = " ",
						nvim_lua = " ",
						luasnip = "⋗ ",
						buffer = " ",
						path = " ",
					}
					item.menu = menu_icon[entry.source.name]
					return require("tailwindcss-colorizer-cmp").formatter(entry, item)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			experimental = {
				ghost_text = false,
				native_menu = false,
			},
		})
	end,
}
