return {
  "saghen/blink.cmp",
  version = "1.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
      menu = {
        auto_show = true,
      },
    },
    keymap = {
      preset = "enter",
    },
  },
  opts_extend = { "sources.default" },
}
