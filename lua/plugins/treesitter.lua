return {
  "nvim-treesitter/nvim-treesitter", 
  config = function ()
    -- Using protected call
    local status_ok, treesitter = pcall(require, "nvim-treesitter")
    if not status_ok then
      return
    end
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup {
      ensure_installed = { "lua", "vim", "markdown", "markdown_inline", "latex", "bash", "python", "cpp", "c", "java", "javascript", "typescript", "tsx", "html", "css" }, -- put the language you want in this array
      -- ensure_installed = "all", -- one of "all" or a list of languages
      ignore_install = { "" }, -- List of parsers to ignore installing
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
      },
      indent = { enable = true, disable = { "python", "css" } },

      -- Integration with other plugins
      autopairs = { -- require autopairs plugin
        enable = true,
      },
      context_commentstring = { -- require ts-comment string plugin
        enable = true,
        enable_autocmd = false,
      },
    }
  end
}
