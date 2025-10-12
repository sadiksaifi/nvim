---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "require" }
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		}
	}
}
