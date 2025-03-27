return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {},
      cmd = "Mason",
    },
  },
  opts = {
    ensure_installed = require("user.languages").servers,
  },
}
