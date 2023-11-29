return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	keys = {
		{ "<leader>ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
	},
	opts = {
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "bottom", -- | top | left | right
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
				dismiss = "<M-h>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
			},
		},
    filetypes = {
      ["."] = true,
      go = false,
      c = false,
      cpp = false,
    },
    copilot_node_command = vim.fn.expand("$HOME") .. "/n/n/versions/node/20.10.0/bin/node", -- Node.js version must be > 18.x
		server_opts_overrides = {},
	},
}
