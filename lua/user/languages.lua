local M = {}

M.servers = {
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
