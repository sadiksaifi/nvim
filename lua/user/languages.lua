local M = {}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  -- "ts_ls",
  "jsonls",
  "tailwindcss",
  "eslint",
  "prismals",
  "gopls",
  "bashls",
  "astro",
  "yamlls",
  -- "dockerls",
  -- "rust_analyzer",
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
