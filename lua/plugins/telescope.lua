local M = {
  { "stevearc/dressing.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "Telescope",
    event = { "LspAttach" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>ft", "<cmd>Telescope live_grep<CR>", desc = "Find a string" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keymaps" },
      { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    },
    config = function()
      local telescope = require "telescope"
      telescope.setup {
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
        defaults = {
          file_ignore_patterns = { "node_modules/", ".yarn/", ".git/", ".idea/" },
        },
      }

      function _G.Select_from_list(items, on_select, opts)
        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"
        local themes = require "telescope.themes"

        opts = opts or {}

        -- Get dropdown theme and override layout_config
        local dropdown_opts = themes.get_dropdown {
          previewer = false,
          prompt_title = opts.prompt_title or "Select an Item",
        }

        -- Override the layout_config to make width work
        dropdown_opts.layout_config = {
          width = opts.width or 0.5,
          height = opts.height or 0.4,
          prompt_position = "top",
        }

        pickers
          .new(dropdown_opts, {
            finder = finders.new_table {
              results = items,
            },
            sorter = conf.generic_sorter(dropdown_opts),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection and on_select then
                  on_select(selection[1])
                end
              end)
              return true
            end,
          })
          :find()
      end

    end,
  },
}

return M
