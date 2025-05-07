vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.wildmenu = true -- completion of commands
vim.opt.wildignorecase = true -- case insensitive completion
vim.opt.wildmode = "longest,full,full" -- how the completion is done
vim.opt.background = "dark"
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

-- vim.opt.linebreak = true -- Enable line breaks
-- vim.opt.laststatus = 1                                 -- disables the status line
-- vim.o.guicursor = "" -- disable cursor dynamic behavior
-- vim.opt.wildignore =
--   ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
-- vim.opt.fillchars = {
--   eob = " ", -- set end-of-buffer character to a space
--   fold = " ", -- set fold character to a space
--   diff = " ", -- set diff character to a space
--   msgsep = "‾", -- set message separator character to a horizontal bar
-- }
-- vim.opt.mouse = "a" -- allow the mouse to be used in neovim
-- vim.opt.pumheight = 10 -- pop up menu height
-- vim.opt.showtabline = 1 -- always show tabs
-- vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
-- vim.opt.showmode = true -- we don't need to see things like -- INSERT -- anymore
-- vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
-- vim.opt.hlsearch = true -- highlight all matches on previous search pattern
-- vim.opt.expandtab = true -- convert tabs to spaces
-- vim.opt.laststatus = 3 -- only the last window will always have a status line
-- vim.opt.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
-- vim.opt.ruler = false -- hide the line and column number of the cursor position
-- vim.opt.numberwidth = 4 -- minimal number of columns to use for the line number {default 4}
