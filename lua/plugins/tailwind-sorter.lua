return {
  "laytan/tailwind-sorter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
  build = "cd formatter && npm i && npm run build",
  config = function()
    -- Using protected call
    local status_ok, tailwind_sorter = pcall(require, "tailwind-sorter")
    if not status_ok then
      return
    end

    tailwind_sorter.setup({
      on_save_enabled = false,
      on_save_pattern = {
        "*.html",
        "*.js",
        "*.jsx",
        "*.tsx",
        "*.twig",
        "*.hbs",
        "*.php",
        "*.heex",
      },
      node_path = "node",
    })
  end,
}
