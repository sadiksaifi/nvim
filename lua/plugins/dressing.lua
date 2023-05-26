return {
  "stevearc/dressing.nvim",
  event = "BufRead",
  config = function()
    local status_ok, dressing = pcall(require, "dressing")
    if not status_ok then
      return
    end
    dressing.setup({
      input = {
        enabled = true,
        default_prompt = "Input:",
        title_pos = "left",
        insert_only = true,
        start_in_insert = true,
        anchor = "SW",
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          winblend = 10,
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = nil,

        -- Options for fzf selector
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },

        -- Options for fzf-lua
        fzf_lua = {
          -- winopts = {
          --   height = 0.5,
          --   width = 0.5,
          -- },
        },

        -- Options for nui Menu
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 10,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },

        -- Options for built-in selector
        builtin = {
          -- These are passed to nvim_open_win
          anchor = "NW",
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "editor",

          buf_options = {},
          win_options = {
            -- Window transparency (0-100)
            winblend = 10,
          },

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- the min_ and max_ options can be a list of mixed types.
          -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },

          -- Set to `false` to disable
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil,
      },
    })
  end,
}
