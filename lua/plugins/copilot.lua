return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  keys = {
    { "<leader>tc", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
  },
  opts = {
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        dismiss = "<M-h>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    filetypes = {
      ["."] = true,
      go = false,
      c = false,
      rust = false,
      cpp = false,
    },
    server_opts_overrides = {},
  },
}
