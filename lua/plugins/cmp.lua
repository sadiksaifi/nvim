return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    event = { "BufReadPre", "BufNewFile" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      signature = {
        enabled = true,
        window = { border = "single" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        menu = {
          auto_show = true,
          border = "single",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "source_name", "kind", gap = 1 } },
            components = {
              source_name = {
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
        },
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
      },
    },
    opts_extend = { "sources.default" },
  },
}
