return {
	"laytan/tailwind-sorter.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
	build = "cd formatter && npm i && npm run build",
  cmd = "TailwindSort",
	opts = {
		on_save_enabled = false,
		on_save_pattern = {
			"*.html",
			"*.js",
			"*.jsx",
			"*.tsx",
			"*.twig",
			"*.hbs",
			"*.php",
			"*.heex",
		},
		node_path = "node",
	},
}
