return {
  "Mofiqul/vscode.nvim",
  priority = 100,
  config = function()
    local code = require "vscode"

		code.setup {
			transparent = false,
		}

    vim.cmd "colorscheme vscode"
  end,
}
