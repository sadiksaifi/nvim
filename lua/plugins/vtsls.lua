return {
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
    local keys = {}
    for key, _ in pairs(options) do
      table.insert(keys, key)
    end

    local function select_vtsls()
      require("telescope").extensions.select_from_list(keys, function(result)
        if type(options[result]) == "function" then
          options[result]()
          return
        end
        vim.cmd("VtsExec " .. options[result])
      end)
    end

    vim.keymap.set("n", "<leader>t", select_vtsls, { desc = "Select file" })
  end,
}
