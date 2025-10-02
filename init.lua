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
keymap("n", "<leader>G", ":Neogit<cr>")

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
vim.cmd("set completeopt+=noselect")
vim.g.netrw_banner = 0 -- disable that anoying Netrw banner
vim.g.netrw_browser_split = 4 -- open in a prior window
vim.g.netrw_list_hide = "^\\./\\?$,^\\.\\./\\?$" -- hide ./ and ../

-- Auto Commands
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Briefly highlight yanked text",
})

-- Plugins
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",

	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/NeogitOrg/neogit",

	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/sadiksaifi/line.nvim",

	"https://github.com/supermaven-inc/supermaven-nvim",
	"https://github.com/vague2k/vague.nvim",
})

-- LSP
local servers = { "lua_ls", "vtsls", "tailwindcss", "jsonls", "eslint", "cssls", "html", "gopls" }
vim.lsp.enable(servers)
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
})

local pick = require("mini.pick")
pick.setup()

require("mason").setup()
require("supermaven-nvim").setup({
	keymaps = {
		accept_suggestion = "<C-l>",
		clear_suggestion = "<C-h>",
	},
	ignore_filetypes = { go = true },
})
---@diagnostic disable-next-line: missing-fields
require("line").setup({ theme = "boring", components = { extension = false } })
require("vague").setup()
vim.cmd("colorscheme vague")
require("blink.cmp").setup({
	completion = {
		menu = {
			draw = {
				columns = { { "label", "label_description", gap = 1 }, { "source_name", "kind", gap = 1 } },
				components = {
					source_name = {
						text = function(ctx)
							return "[" .. ctx.source_name .. "]"
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
		},
		accept = {
			auto_brackets = {
				enabled = false,
			},
		},
	},
})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "javascript", "typescript", "tsx", "html", "css", "json", "yaml", "go" },
	highlight = { enable = true },
	indent = { enable = true },
})

-- formatter
require("conform").setup({
	log_level = vim.log.levels.DEBUG,
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		javascript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},

	["*"] = { "codespell" },
	-- Use the "_" filetype to run formatters on filetypes that don't
	-- have other formatters configured.
	["_"] = { "trim_whitespace" },
})
keymap("n", "gff", require("conform").format)

local TsCmds = function()
	vim.ui.select({ "tsc", "eslint" }, { prompt = "Select a command to run" }, function(choice)
		if not choice then
			return
		end

		pcall(vim.cmd.compiler, choice)
		if choice == "tsc" then
			vim.opt.makeprg = "npx tsc --noEmit"
		else
			vim.opt.makeprg = "npx eslint ."
		end

		vim.cmd("silent make")

		if #vim.fn.getqflist() > 0 then
			vim.cmd("copen")
		else
			vim.notify(choice .. " passed successfully.", vim.log.levels.INFO)
		end
	end)
end
keymap("n", "<leader>ts", TsCmds)
