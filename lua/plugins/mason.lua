return {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = {
    ensure_installed = require("utils").servers,
    automatic_installation = true,
  },
  dependencies = {
    "williamboman/mason.nvim",
    event = { "BufRead", "BufNewFile" },
    keys = {
      { "<leader>lI", "<cmd>Mason<CR>", desc = "Opens Mason" },
    },
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
    opts = {
      ui = {
        border = "rounded",
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  },
}
