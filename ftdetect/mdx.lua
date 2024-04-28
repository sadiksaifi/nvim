vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})


vim.treesitter.language.register("markdown", "mdx") -- the mdx filetype will use the markdown parser and queries.
