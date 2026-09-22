return {
  "NeogitOrg/neogit",
  lazy = true,
  init = function()
    local group = vim.api.nvim_create_augroup("neogit_wrap", { clear = true })

    local function enable_wrap(buf)
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        for _, win in ipairs(vim.fn.win_findbuf(buf)) do
          vim.wo[win].wrap = true
          vim.wo[win].linebreak = true
        end
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "Neogit*",
      callback = function(event)
        enable_wrap(event.buf)
      end,
    })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = group,
      callback = function(event)
        if vim.bo[event.buf].filetype:match("^Neogit") then
          enable_wrap(event.buf)
        end
      end,
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required

    -- Only one of these is needed.
    "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>G", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
}
