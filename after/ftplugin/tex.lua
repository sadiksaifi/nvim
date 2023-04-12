vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.tex" },
	callback = function()
		vim.api.nvim_command("silent !pdflatex %")
	end,
})

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.spell = true
vim.keymap.set("n", "<leader>p", ":silent !zathura %:r.pdf &<CR>", { noremap = true, silent = true } )
