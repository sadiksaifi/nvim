-- Generate Highlight Test File: :so $VIMRUNTIME/syntax/hitest.vim
vim.cmd[[
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

function! GetGitBranch()
  let branch = system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  return empty(branch) ? '' : ' ' . branch[:-2]
endfunction

set statusline= " Clear statusline
set statusline+=\%#RedrawDebugComposed# " Set highlight group to CursorLine 
set statusline+=\ %{toupper(g:currentmode[mode()])} " Show current mode
set statusline+=\%#NeogitDiffAddHighlight# " Set highlight group to CursorLine 
set statusline+=\ %{GetGitBranch()} " Show Git branch
set statusline+=\ %#CursorLine# " Set highlight group to CursorLine 
set statusline+=%= " Right align following items
set statusline+=\%{&modified?'[+]':''} " Show [+} if file is modified
set statusline+=\%r " Shows status of read only files
set statusline+=\ %f " Show path to file
set statusline+=\ %#NeogitDiffAddHighlight# " Set highlight group to CursorLine 
set statusline+=\ %c:%l " Show cursor position
set statusline+=\ %#RedrawDebugComposed# " Set highlight group to CursorLine 
set statusline+=\ %p%% " Show percentage through file
set statusline+=\  " Show percentage through file
]]
