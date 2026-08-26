vim.filetype.add({
  filename = {
    [".env"] = "dotenv",
    [".dev.vars"] = "dotenv",
  },
  pattern = {
    ["%.env%..*"] = "dotenv",
    [".*%.vars"] = "dotenv",
  },
})

-- Reuse Bash highlighting without attaching shell-specific tooling such as bashls.
vim.treesitter.language.register("bash", "dotenv")
