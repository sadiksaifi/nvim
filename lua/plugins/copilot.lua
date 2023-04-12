return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    -- Using protected call
    local ok, copilot = pcall(require, "copilot")
    if not ok then
      return
    end

    copilot.setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          dismiss = "<M-h>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      copilot_node_command = 'node', -- Node.js version must be > 16.x
      server_opts_overrides = {},
    })

    -- Setting Keymaps
    vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<CR>", { silent = true })
  end,
}
