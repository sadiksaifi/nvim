local M = {}

M.server_names = {
  "lua-language-server",
  "css-lsp",
  "html-lsp",
  "json-lsp",
  "vtsls",
  "tailwindcss-language-server",
  "eslint-lsp",
  "gopls",
  "bash-language-server",
  "astro-language-server",
  "yaml-language-server",
}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  "jsonls",
  "vtsls",
  "tailwindcss",
  "eslint",
  "prismals",
  "gopls",
  "bashls",
  "astro",
  "yamlls",
}

M.parsers = {
  "lua",
  "vim",
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
  "stylua",
}

return M
