local M = {}

M.servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "bashls",
  "jsonls",
  "yamlls",
  "tailwindcss",
  "gopls",
  "astro",
  "jdtls",
  "pylsp",
  "clangd",
  "eslint"
}

M.linters = {
  "prettier",
  "stylua",
  "black",
}

M.parsers = {
  "lua",
  "vim",
  "markdown",
  "markdown_inline",
  "latex",
  "bash",
  "python",
  "cpp",
  "c",
  "java",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "json",
  "yaml",
  "toml",
  "regex",
  "go",
  "rust",
  "dockerfile",
}

return M
