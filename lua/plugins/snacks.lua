local filtered_message = { "No information available" }
local excluded_paths = {
  "node_modules",
  "ios",
  "dist",
  "build",
  "android",
  ".bin",
  ".tmp",
  "target",
  ".next",
  ".expo",
  ".tanstack",
  ".alchemy",
}

return {
  ---@module 'snacks'
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {},

  ---@type snacks.Config
  opts = {
    explorer = {
      enabled = true,
      win = {
        width = 10,
      },
    },
    input = {
      enabled = true,
      win = {
        relative = "cursor",
        col = -3,
        row = -3,
        title_pos = "left",
      },
    },
    picker = {
      enabled = true,
      sources = {
        picker = {
          formatters = {
            file = {
              truncate = 10000,
            },
          },
        },
        files = {
          title = "Find Files",
          hidden = true,
          ignored = true,
          exclude = excluded_paths,
          layout = {
            preset = "select", -- "select" layout style
          },
        },
        grep = {
          hidden = false,
          ignored = false,
          layout = {
            preset = "telescope",
          },
        },
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            preset = "sidebar",
            layout = {
              width = 0.24, -- 30% of screen width, adjust as needed
            },
          },
          win = {
            list = {
              keys = {
                ["."] = "",
                ["-"] = "explorer_close",
                ["<tab>"] = "",
                ["<s-tab>"] = "",
              },
            },
          },
        },
      },
    },
    rename = { enabled = true },
    terminal = {},
    styles = {},
    indent = { enabled = true },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        local notify = Snacks.notifier.notify
        ---@diagnostic disable-next-line: duplicate-set-field
        Snacks.notifier.notify = function(message, level, opts)
          for _, msg in ipairs(filtered_message) do
            if message == msg then
              return nil
            end
          end
          return notify(message, level, opts)
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "[E]xplorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "[F]ind [F]iles",
    },
    {
      "<leader>ft",
      function()
        Snacks.picker.grep()
      end,
      desc = "[F]ind [T]ext",
    },
    {
      "<leader>s",
      function()
        Snacks.scratch()
      end,
      desc = "[F]ind [S]cratch",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "[S]elect [S]cratch",
    },
  },
}
