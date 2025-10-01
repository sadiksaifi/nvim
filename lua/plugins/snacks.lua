return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true, -- Replace netrw with the snacks explorer
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
      indent = {
        enabled = true,
        animate = {
          enabled = false,
        },
      },
      picker = {
        enabled = true,
        sources = {
          smart = {
            title = "Find Files",
            layout = {
              preset = "select", -- "select" layout style
              preview = false, -- disable preview window
            },
          },
          grep = {
            layout = {
              preset = "telescope",
              preview = true,
            },
          },
        },
      },
      styles = {},
    },
    keys = {
      -- Top Pickers & Explorer
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>ft",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>s",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
    },
  },
  { "nvim-mini/mini.icons", version = false },
}
