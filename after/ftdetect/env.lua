vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".dev.vars"] = "sh",
  },
  pattern = {
    ["%.env%..*"] = "sh",
    [".*%.vars"] = "sh",
  },
})
