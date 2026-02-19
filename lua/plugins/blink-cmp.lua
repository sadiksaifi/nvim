return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    version = "v1.*",
    opts = {
      sources = {
        -- add lazydev to your completion providers
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
      completion = {
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "source_name", "kind", gap = 1 },
            },
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
  },
}
