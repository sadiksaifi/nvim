-- Keymap
vim.g.mapleader = " "
local keymap = function(mode, keys, func)
	vim.keymap.set(mode, keys, func, { silent = true, noremap = true })
end
keymap("n", "<leader>.", vim.cmd.Ex)
keymap("x", "<", "<gv")
keymap("x", ">", ">gv")
keymap("v", "p", '"_dP')
keymap("n", "<leader>ff", ":Pick files tool=git<cr>")
keymap("n", "<leader>ft", ":Pick grep_live<cr>")

-- Options
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest,full,full"
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.winborder = "rounded"
vim.cmd("set completeopt=menuone,noselect")

-- Auto Commands
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Briefly highlight yanked text",
})

-- Plugins
vim.pack.add({
	"https://github.com/nvim-mini/mini.pick",
})

-- LSP
vim.lsp.enable('vtsls')
vim.lsp.enable('lua_ls')

require("mini.pick").setup()
