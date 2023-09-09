vim.opt_local.commentstring = "//%s"
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.c" },
	callback = function()
		-- vim.api.nvim_command("!g++ % -o %:r.out")
		vim.api.nvim_command("silent !g++ %")
	end,
})
