vim.opt_local.commentstring = "//%s"
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.cpp" },
	callback = function()
		-- vim.api.nvim_command("!g++ % -o %:r.out")
		vim.api.nvim_command("silent !g++ %")
	end,
})
