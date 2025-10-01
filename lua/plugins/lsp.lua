return {
  {
    "mason-org/mason.nvim",
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = { ensure_installed = require("user.languages").servers },
    },
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
      -- diagnostic config
      vim.diagnostic.config {
        virtual_text = true,
        update_in_insert = false,
        underline = true,
      }
      local servers = require("user.languages").servers
      -- for _, server in ipairs(servers) do
      --   vim.lsp.config(server, { cmd = { "true" } })
      -- end
      vim.lsp.enable(servers)

      local on_attach = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)
        keymap("n", "gl", vim.diagnostic.open_float, opts)
        keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)

        -- TypeScript-specific keymap
        if client and (client.name == "vtsls" or client.name == "tsserver") then
          keymap("n", "gl", "<cmd>PrettyTsError<cr>", opts)
        end
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = on_attach,
      })
    end,
  },
}
