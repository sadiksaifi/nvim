return {
  "akinsho/bufferline.nvim",
  event = "BufRead",
  dependencies = {
    {
      "famiu/bufdelete.nvim",
      keys = {
        { "<leader>x", "<cmd>Bdelete<CR>", desc = "Delete buffer" },
      },
    },
  },
  opts = {
    options = {
      close_command = "Bdelete! %d",    -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      offsets = {
        {
          filetype = "undotree",
          text = "Undotree",
          highlight = "PanelHeading",
          padding = 0,
        },
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 0,
        },
        {
          filetype = "DiffviewFiles",
          text = "Diff View",
          highlight = "PanelHeading",
          padding = 0,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          highlight = "PanelHeading",
        },
        {
          filetype = "lazy",
          text = "Lazy",
          highlight = "PanelHeading",
          padding = 0,
        },
      },
      separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    },
    highlights = {
      fill = {
        fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultError" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      background = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      buffer_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      tab_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      tab = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      tab_close = {
        fg = { attribute = "fg", highlight = "TabLineSel" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      duplicate_selected = {
        fg = { attribute = "fg", highlight = "TabLineSel" },
        bg = { attribute = "bg", highlight = "TabLineSel" },
        italic = true,
      },
      duplicate_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
        italic = true,
      },
      duplicate = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
        italic = true,
      },
      modified = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      modified_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      modified_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      separator = {
        fg = { attribute = "bg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      separator_selected = {
        fg = { attribute = "bg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      indicator_selected = {
        fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
    },
  },
}
