return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    version = "v1.*",
    opts = {
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
