local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { noremap = true, silent = true })

require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
  install = {
    colorscheme = { "rose-pine", "default" },
  },
  ui = {
    border = "rounded",
  },
})
