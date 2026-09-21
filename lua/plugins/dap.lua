local js_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}

return {
  {
    "mfussenegger/nvim-dap",
    cmd = {
      "DapContinue",
      "DapDisconnect",
      "DapNew",
      "DapPause",
      "DapRestartFrame",
      "DapStepInto",
      "DapStepOut",
      "DapStepOver",
      "DapTerminate",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapViewToggle",
    },
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        version = "1.*",
      },
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Debug continue",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
            if condition and condition ~= "" then
              require("dap").set_breakpoint(condition)
            end
          end)
        end,
        desc = "Debug conditional breakpoint",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Debug step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Debug step into",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Debug step out",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Debug run last",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Debug toggle REPL",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Debug terminate",
      },
      {
        "<leader>dv",
        function()
          require("dap-view").toggle()
        end,
        desc = "Debug toggle view",
      },
      {
        "<leader>dh",
        function()
          require("dap-view").hover()
        end,
        mode = { "n", "v" },
        desc = "Debug inspect value",
      },
      {
        "<leader>dg",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug nearest Go test",
      },
      {
        "<leader>dG",
        function()
          require("dap-go").debug_last_test()
        end,
        desc = "Debug last Go test",
      },
    },
    config = function()
      local dap = require("dap")

      require("dap-view").setup({
        auto_toggle = true,
        virtual_text = {
          enabled = true,
        },
        winbar = {
          sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
          controls = {
            enabled = true,
          },
        },
      })

      require("dap-go").setup()

      local js_debug_adapter = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}", "127.0.0.1" },
        },
      }

      local adapter_aliases = {
        chrome = "pwa-chrome",
        node = "pwa-node",
        ["pwa-chrome"] = "pwa-chrome",
        ["pwa-node"] = "pwa-node",
      }

      for adapter_name, target_type in pairs(adapter_aliases) do
        local resolved_type = target_type
        local adapter = vim.deepcopy(js_debug_adapter)
        adapter.enrich_config = function(config, on_config)
          if config.type == resolved_type then
            on_config(config)
            return
          end

          local resolved_config = vim.deepcopy(config)
          resolved_config.type = resolved_type
          on_config(resolved_config)
        end
        dap.adapters[adapter_name] = adapter
      end

      local js_configurations = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file with Node",
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node on port 9229",
          port = 9229,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
      }

      for _, filetype in ipairs(js_filetypes) do
        dap.configurations[filetype] = vim.deepcopy(js_configurations)
      end

      local signs = {
        DapBreakpoint = { text = "●", texthl = "DiagnosticError" },
        DapBreakpointCondition = { text = "◆", texthl = "DiagnosticWarn" },
        DapBreakpointRejected = { text = "○", texthl = "DiagnosticError" },
        DapLogPoint = { text = "◆", texthl = "DiagnosticInfo" },
        DapStopped = { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" },
      }

      for name, sign in pairs(signs) do
        vim.fn.sign_define(name, sign)
      end
    end,
  },
}
