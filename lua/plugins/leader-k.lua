return {
  dir = vim.fn.expand("~/Projects/leader-k.nvim"),
  name = "leader-k",
  cmd = "LeaderK",
  keys = {
    {
      "<leader>k",
      function()
        require("leader-k").open()
      end,
      mode = { "n", "x" },
      desc = "Edit selection with AI",
    },
  },
  ---@type leader_k.Config
  opts = {
    base_url = "https://openrouter.ai/api/v1",
    model = "deepseek/deepseek-v4.1-flash",
    api_key = { env = "LEADER_K_OPENROUTER_API_KEY" },
    params = {
      reasoning = { effort = "none" },
    },
  },
}
