local M = {}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "jsonls",
  "tailwindcss",
  "eslint",
  "prismals",
  "gopls",
  "bashls"
}

M.parsers = {
  "lua",
  "markdown",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "json",
  "yaml",
  "go",
  "dockerfile",
}

M.fmtNLint = {
  "prettier",
  "stylua"
}

return M
