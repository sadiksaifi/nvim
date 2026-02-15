return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  event = { "BufEnter" },
  opts = {
    ensure_installed = {
      "bash",
      "lua",
      "vim",
      "go",
      "rust",
      "sql",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "svelte",
      "astro",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
    },
    sync_install = false,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}
