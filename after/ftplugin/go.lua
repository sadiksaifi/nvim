-- after/ftplugin/go.lua
-- Go formatting: use tabs, visually equivalent to 4 spaces
vim.opt_local.expandtab = false -- use tabs instead of spaces
vim.opt_local.tabstop = 4 -- a tab is displayed as 4 spaces
vim.opt_local.shiftwidth = 4 -- indentation level is 4 spaces
vim.opt_local.softtabstop = 4 -- editing feels like 4 spaces per tab
