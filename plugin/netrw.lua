vim.g.netrw_banner=0        -- disable that anoying Netrw banner
vim.g.netrw_browser_split=4   -- open in a prior window
vim.g.netrw_altv=1            -- open splits to the right
-- vim.g.netrw_liststyle=3       -- treeview

-- keymap file explorer
vim.keymap.set("n", "<leader>.", vim.cmd.Ex, { silent = true, noremap = true })
