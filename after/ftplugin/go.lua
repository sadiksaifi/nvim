-- Go formatters use tabs. Display each indentation level as four columns.
vim.bo.expandtab = false
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. " | setlocal expandtab< tabstop< shiftwidth< softtabstop<"
