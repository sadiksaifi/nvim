vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = true,
  float = {
    border = "rounded",
    focusable = true,
    style = "minimal",
    source = true,
  },
}
