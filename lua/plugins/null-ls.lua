return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    automatic_setup = true,
    ensure_installed = require("utils").linters,
    automatic_installation = true,
  },
  dependencies = {
    {
      "nvimtools/none-ls.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      keys = {
        {
          "<leader>lf",
          "<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
          desc = "Format",
        },
        { "<leader>ln", "<cmd>NullLsInfo<cr>", desc = "NullLsInfo" },
      },
      config = function()
        -- Using protected call
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local diagnostics = null_ls.builtins.diagnostics

        -- Setting up null ls
        null_ls.setup({
          debug = false,
          sources = {
            formatting.prettier,
          },
          on_attach = function(current_client, bufnr)
            if current_client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({
                    filter = function(client)
                      --  only use null-ls for formatting instead of lsp server
                      return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                  })
                end,
              })
            end
          end,
        })
      end,
    },
  },
}
