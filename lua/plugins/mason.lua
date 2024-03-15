return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
        },
      },
      keys = {
        { "<leader>lI", "<cmd>Mason<CR>", desc = "Opens Mason" },
      },
    },
  },
  opts = {
    ensure_installed = require("user.languages").servers
  },
}
