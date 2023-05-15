return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
    { "<leader>gl", "<cmd>Git log<CR>", desc = "Git Log" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git Commit" },
    { "<leader>gC", "<cmd>Git commit --amend<CR>", desc = "Git Commit Amend" },
    { "<leader>gp", "<cmd>Git pull<CR>", desc = "Git Pull" },
    { "<leader>gP", "<cmd>Git push<CR>", desc = "Git Push" },
    { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git Blame" },
    { "<leader>gB", "<cmd>Git branch<CR>", desc = "Git Branch" },
    { "<leader>ga", "<cmd>Git add %<CR>", desc = "Git Add" },
    { "<leader>gd", "<cmd>Gvdiffsplit!<CR>", desc = "Git Diff" },
    { "<leader>dp", ":diffput ", desc = "Git Diff Put" },
    { "<leader>dg", ":diffget ", desc = "Git Diff Get" },
  },
  config = function ()
    local status_ok, fugitive = pcall(require, "vim-fugitive")
    if not status_ok then
      return
    end
    fugitive.setup({})
  end
}
