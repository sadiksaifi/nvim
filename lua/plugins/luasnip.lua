return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { "./snippets" },
    })
    local ls = require("luasnip")

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      ls.jump(1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      ls.jump(-1)
    end, { silent = true })
  end,
}
