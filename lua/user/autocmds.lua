vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Briefly highlight yanked text",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
