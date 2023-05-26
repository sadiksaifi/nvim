return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  config = function()
    -- Using protected call
    local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    treesitter_config.setup({
      ensure_installed = {
        "lua",
        "vim",
        "markdown",
        "markdown_inline",
        "latex",
        "bash",
        "python",
        "cpp",
        "c",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "regex",
        "go",
        "rust",
        "dockerfile",
      },
      sync_install = false,

      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { "python", "css" } },

      -- Integration with other plugins
      autopairs = { -- require autopairs plugin
        enable = true,
      },
      autotag = { -- require autotag plugin
        enable = true,
      },
      context_commentstring = { -- require ts-comment string plugin
        enable = true,
        enable_autocmd = false,
      },
    })
  end,
}
