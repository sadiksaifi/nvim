-- Plugins
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/sadiksaifi/line.nvim',
  -- 'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/supermaven-inc/supermaven-nvim',
  'https://github.com/Exafunction/windsurf.nvim',
  'https://github.com/vague2k/vague.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/yioneko/nvim-vtsls',
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range('1.*'),
  },
})

local mini_icons = require('mini.icons')
local mason = require('mason')
-- local copilot = require('copilot')
-- local codeium = require('codeium')
local supermaven = require('supermaven-nvim')
local line = require('line')
local vague = require('vague')
local blink = require('blink.cmp')
local treesitter = require('nvim-treesitter.configs')
local conform = require('conform')
local snacks = require('snacks')

mini_icons.setup()
mason.setup()
vague.setup({
  transparent = true,
})

-- LSP
local servers = {
  'lua_ls',
  'vtsls',
  'tailwindcss',
  'jsonls',
  'eslint',
  'cssls',
  'html',
  'gopls',
  'yamlls',
  'postgres_lsp',
  'astro',
}
vim.lsp.enable(servers)
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
})

-- Colorscheme
vim.cmd('colorscheme vague')

-- Statusline
---@diagnostic disable-next-line: missing-fields, undefined-field
line.setup({ theme = 'boring', components = { extension = false } })

-- Autocompletion
-- codeium.setup({
--   enable_cmp_source = false,
--   virtual_text = {
--     enabled = true,
--     key_bindings = {
--       accept = '<C-l>',
--       -- Accept the next word.
--       accept_word = false,
--       -- Accept the next line.
--       accept_line = false,
--       -- Clear the virtual text.
--       clear = false,
--       -- Cycle to the next completion.
--       next = '<M-]>',
--       -- Cycle to the previous completion.
--       prev = '<M-[>',
--     },
--   },
-- })

-- Autocompletion
-- copilot.setup({
--   suggestion = {
--     enabled = true,
--     auto_trigger = true,
--     hide_during_completion = true,
--     debounce = 75,
--     trigger_on_accept = true,
--     keymap = {
--       accept = '<C-l>',
--       accept_word = false,
--       accept_line = false,
--       next = '<M-]>',
--       prev = '<M-[>',
--       dismiss = '<C-]>',
--     },
--   },
-- })

-- Autocompletion
supermaven.setup({
  keymaps = {
    accept_suggestion = '<C-l>',
    clear_suggestion = '<C-h>',
    accept_word = '<C-j>',
  },
})

-- Completion Menu
blink.setup({
  completion = {
    menu = {
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'source_name', 'kind', gap = 1 },
        },
        components = {
          source_name = {
            text = function(ctx) return '[' .. ctx.source_name .. ']' end,
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

-- Treesitter
---@diagnostic disable-next-line: missing-fields
treesitter.setup({
  ensure_installed = {
    'lua',
    'vim',
    'javascript',
    'typescript',
    'tsx',
    'html',
    'css',
    'json',
    'yaml',
    'go',
    'sql',
    'markdown',
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Formatter
conform.setup({
  log_level = vim.log.levels.DEBUG,
  formatters = {
    staticcheck = {
      command = 'staticcheck',
      args = { '-f', 'json', './...' },
      stdin = false,
      parse = function(output)
        local diags = {}
        for line in output:gmatch('[^\n]+') do
          local ok, item = pcall(vim.json.decode, line)
          if ok and item and item.location then
            table.insert(diags, {
              lnum = item.location.line - 1,
              col = item.location.column - 1,
              message = item.message,
              severity = vim.diagnostic.severity.WARN,
              source = 'staticcheck',
            })
          end
        end
        return diags
      end,
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    typescript = { 'prettierd', 'prettier' },
    typescriptreact = { 'prettierd', 'prettier' },
    javascript = { 'prettierd', 'prettier' },
    javascriptreact = { 'prettierd', 'prettier' },
		astro = { 'prettierd', 'prettier' },
    go = { 'staticcheck' }, -- add staticcheck as a linter
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },

  ['*'] = { 'codespell' },
  -- Use the "_" filetype to run formatters on filetypes that don't
  -- have other formatters configured.
  ['_'] = { 'trim_whitespace' },
})

-- Snacks
snacks.setup({
  explorer = {
    enabled = true,
    win = {
      width = 10,
    },
  },
  input = {
    enabled = true,
    win = {
      relative = 'cursor',
      col = -3,
      row = -3,
      title_pos = 'left',
    },
  },
  picker = {
    enabled = true,
    sources = {
      picker = {
        formatters = {
          file = {
            truncate = 10000,
          },
        },
      },
      files = {
        title = 'Find Files',
        hidden = true,
        layout = {
          preset = 'select', -- "select" layout style
          preview = false, -- disable preview window
        },
      },
      grep = {
        layout = {
          preset = 'telescope',
          preview = true,
        },
      },
      explorer = {
        hidden = true,
        ignored = true,
        layout = {
          preset = 'sidebar',
          layout = {
            width = 0.24, -- 30% of screen width, adjust as needed
          },
        },
        win = {
          list = {
            keys = {
              ['.'] = '',
              ['-'] = 'explorer_close',
              ['<tab>'] = '',
              ['<s-tab>'] = '',
            },
          },
        },
      },
    },
  },
  rename = { enabled = true },
  terminal = {},
  styles = {},
  indent = { enabled = true },
})

local TsCmds = function()
  local options = {
    ['Rename file'] = 'rename_file',
    ['Sort imports'] = 'sort_imports',
    ['Add missing imports'] = 'add_missing_imports',
    ['Remove unused imports'] = 'remove_unused_imports',
    ['Remove unused'] = 'remove_unused',
    ['File references'] = 'file_references',
    ['Restart tsserver'] = 'restart_tsserver',
    ['Fix all'] = 'fix_all',
    ['Organize imports'] = 'organize_imports',
    ['Open tsserver log'] = 'open_tsserver_log',
    ['Select ts version'] = 'select_ts_version',
    ['Reload projects'] = 'reload_projects',
    ['Goto project config'] = 'goto_project_config',
    ['Goto source definition'] = 'goto_source_definition',
    ['Source actions'] = 'source_actions',
    ['Run TSC'] = function()
      vim.notify('Running tsc..', vim.log.levels.INFO)
      pcall(vim.cmd.compiler, 'tsc')
      vim.opt_local.makeprg = 'npx tsc --noEmit --incremental'
      vim.cmd('silent make')
      if #vim.fn.getqflist() > 0 then
        vim.cmd.copen()
      else
        vim.notify('tsc' .. ' passed successfully.', vim.log.levels.INFO)
      end
    end,
    ['Run ESLint'] = function()
      vim.notify('Running eslint...', vim.log.levels.INFO)
      pcall(vim.cmd.compiler, 'eslint')
      vim.opt_local.makeprg = 'npx eslint .'
      vim.cmd('silent make')
      if #vim.fn.getqflist() > 0 then
        vim.cmd.copen()
      else
        vim.notify('eslint' .. ' passed successfully.', vim.log.levels.INFO)
      end
    end,
    ['ESLint Fix'] = function()
      vim.notify('Running eslint --fix...', vim.log.levels.INFO)
      pcall(vim.cmd.compiler, 'eslint')
      vim.opt_local.makeprg = 'npx eslint --fix'
      vim.cmd('silent make')
      if #vim.fn.getqflist() > 0 then
        vim.cmd.copen()
      else
        vim.notify('eslint --fix' .. ' passed successfully.', vim.log.levels.INFO)
      end
    end,
  }

  local keys = {}
  for key, _ in pairs(options) do
    table.insert(keys, key)
  end

  vim.ui.select(keys, { prompt = 'Select a command to run' }, function(choice)
    if not choice then return end

    local action = options[choice]
    if type(action) == 'function' then
      action()
    else
      vim.cmd('VtsExec ' .. action)
    end
  end)
end

-- Auto Commands
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  desc = 'Briefly highlight yanked text',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'opencode_terminal',
  callback = function()
    vim.defer_fn(function() vim.cmd('wincmd l') end, 20)
  end,
})

-- User Commands
-- GoCmd
vim.api.nvim_create_user_command('GoCmd', function()
  local options = {
    ['Go Build'] = function()
      vim.notify('Running go build...', vim.log.levels.INFO)
      vim.cmd.compiler('go') -- good errorformat for Go tools
      vim.opt_local.makeprg = 'go build ./...'
      vim.cmd('silent make')

      if #vim.fn.getqflist() > 0 then
        vim.cmd('copen')
      else
        vim.notify('go build passed successfully.', vim.log.levels.INFO)
      end
    end,

    ['Staticcheck'] = function()
      vim.notify('Running staticcheck...', vim.log.levels.INFO)
      vim.cmd.compiler('go') -- reuse go errorformat
      vim.opt_local.makeprg = 'staticcheck ./...'
      vim.cmd('silent make')

      if #vim.fn.getqflist() > 0 then
        vim.cmd('copen')
      else
        vim.notify('staticcheck passed successfully.', vim.log.levels.INFO)
      end
    end,
  }

  local keys = {}
  for k, _ in pairs(options) do
    table.insert(keys, k)
  end

  vim.ui.select(keys, { prompt = 'Select Go command' }, function(choice)
    if choice then options[choice]() end
  end)
end, {})

-- Keymap
vim.g.mapleader = ' '
local keymap = function(mode, keys, func)
  if type(mode) == 'table' then
    for _, m in ipairs(mode) do
      vim.keymap.set(m, keys, func, { silent = true, noremap = true })
    end
  else
    vim.keymap.set(mode, keys, func, { silent = true, noremap = true })
  end
end

-- Keymap
keymap('n', '<leader>.', vim.cmd.Ex)
keymap('x', '<', '<gv')
keymap('x', '>', '>gv')
keymap('v', 'p', '"_dP')
keymap('n', '<leader>ff', ':Pick files tool=git<cr>')
keymap('n', '<leader>ft', ':Pick grep_live<cr>')
keymap('n', '<leader>G', ':Neogit<cr>')
keymap('n', '<leader>ts', TsCmds)
keymap('n', 'gff', require('conform').format)
keymap('n', '<leader>e', function() snacks.explorer() end)
keymap('n', '<leader>ff', function() snacks.picker.files() end)
keymap('n', '<leader>ft', function() snacks.picker.grep() end)
keymap('n', '<leader>s', function() snacks.scratch() end)
keymap('n', '<leader>S', function() snacks.scratch.select() end)
-- keymap('n', '<leader>cp', function()
--   local path = vim.fn.expand('%')
--   vim.fn.setreg('+', path)
--   vim.notify('Copied: ' .. path)
-- end)
--
keymap('n', '<leader>cp', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path)
end)

-- Opencode keymaps
keymap({ 'n', 't', 'i', 'x', 'v' }, '<C-\\>', function() require('opencode.api').toggle() end)

-- Options
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
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
vim.opt.wildmode = 'longest,full,full'
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'
vim.opt.laststatus = 3
vim.opt.winborder = 'rounded'
vim.opt.wrap = false
vim.opt.colorcolumn = '80'
vim.opt.showmode = false -- because of the statusline
vim.cmd('set completeopt+=noselect')
vim.g.netrw_banner = 0 -- disable that anoying Netrw banner
vim.g.netrw_browser_split = 4 -- open in a prior window
vim.g.netrw_list_hide = '^\\./\\?$,^\\.\\./\\?$' -- hide ./ and ../
