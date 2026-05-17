" JSONC permits trailing commas in common config files.
" Neovim's bundled jsonc syntax still highlights them as errors; clear that
" syntax-only group so <C-w>d is reserved for real diagnostics.
syntax clear jsonTrailingCommaError
