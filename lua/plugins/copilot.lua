return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        keys = {
          { "<leader>ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
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
            debounce = 50,
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
      },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    keys = {
      {
        "<leader>cp",
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>cc",
        "<cmd>CopilotChat<CR>",
        desc = "CopilotChat - Quick chat",
      },
    },
    opts = {
      debug = false,
    },
  },
}
