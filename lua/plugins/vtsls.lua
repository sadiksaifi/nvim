return {
  {
    "yioneko/nvim-vtsls",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },

    config = function()
      local options = {
        ["Rename file"] = "rename_file",
        ["Sort imports"] = "sort_imports",
        ["Add missing imports"] = "add_missing_imports",
        ["Remove unused imports"] = "remove_unused_imports",
        ["Remove unused"] = "remove_unused",
        ["File references"] = "file_references",
        ["Restart tsserver"] = "restart_tsserver",
        ["Fix all"] = "fix_all",
        ["Organize imports"] = "organize_imports",
        ["Open tsserver log"] = "open_tsserver_log",
        ["Select ts version"] = "select_ts_version",
        ["Reload projects"] = "reload_projects",
        ["Goto project config"] = "goto_project_config",
        ["Goto source definition"] = "goto_source_definition",
        ["Source actions"] = "source_actions",
        ["Run TSC"] = function()
          vim.cmd.compiler "tsc"
          vim.opt_local.makeprg = "npx tsc --noEmit"
          vim.cmd "make"
          vim.cmd.copen()
        end,
        ["Run ESLint"] = function()
          vim.cmd.compiler "eslint"
          vim.opt_local.makeprg = "eslint ."
          vim.cmd "make"
          vim.cmd.copen()
        end,
      }

      local function select_vtsls()
        -- Get keys for selection
        local keys = {}
        for key, _ in pairs(options) do
          table.insert(keys, key)
        end

        -- Use Snacks.picker.select - simpler than full picker
        Snacks.picker.select(keys, {
          prompt = "TypeScript Actions",
          format = function(item)
            return item
          end,
        }, function(selected)
          if not selected then
            return
          end

          local action = options[selected]
          if type(action) == "function" then
            action()
          else
            vim.cmd("VtsExec " .. action)
          end
        end)
      end

      vim.keymap.set("n", "<leader>t", select_vtsls, { desc = "TypeScript Actions" })
    end,
  },
  {
    "youyoumu/pretty-ts-errors.nvim",
    cmd = { "PrettyTsError" },
    opts = {
      auto_open = false, -- Automatically show errors on hover
    },
  },
}
