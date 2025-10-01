-- Shorten keymap function
local keymap = function(mode, keys, func)
	vim.keymap.set(mode, keys, func, { silent = true, noremap = true })
end

--Map leader keys
vim.g.mapleader = " "

------------- Normal Mode -------------
-- Better move around
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Clear highlights
keymap("n", "<leader>h", vim.cmd.nohlsearch)

-- Make current file executable
keymap("n", "<leader>xx", "<cmd>!chmod +x %<cr>")

-- Netrw
-- vim.keymap.set("n", "<leader>.", vim.cmd.Ex, { silent = true, noremap = true })

------------- Visual Mode -------------
-- Stay in indent mode
keymap("x", "<", "<gv")
keymap("x", ">", ">gv")
keymap("v", "p", '"_dP') -- Better paste
