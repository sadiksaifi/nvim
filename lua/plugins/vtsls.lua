return {
  "yioneko/nvim-vtsls",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "typescript.tsx" },
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
    }
    local keys = {}
    for key, _ in pairs(options) do
      table.insert(keys, key)
    end

    vim.keymap.set("n", "<leader>t", function()
      Select_from_list(keys, function(result)
        vim.cmd("VtsExec " .. options[result])
      end)
    end, {})
  end,
}
