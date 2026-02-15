return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "gff",
        function()
          require("conform").format()
        end,
        desc = "Format with Conform",
      },
    },
    opts = {
      notify_on_error = false,
      default_format_opts = {
        async = true,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        astro = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        javascript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        typescript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        typescriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
        svelte = { "oxfmt", "prettierd", stop_after_first = true },
        lua = { "stylua" },
      },
      formatters = {
        oxfmt = {
          condition = function(_, ctx)
            return vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, {
              path = ctx.filename,
              upward = true,
              stop = vim.uv.os_homedir(),
            })[1] ~= nil
          end,
        },
        biome = {
          condition = function(_, ctx)
            return vim.fs.find({ "biome.json", "biome.jsonc" }, {
              path = ctx.filename,
              upward = true,
              stop = vim.uv.os_homedir(),
            })[1] ~= nil
          end,
        },
        prettierd = {
          condition = function(_, ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            }, {
              path = ctx.filename,
              upward = true,
              stop = vim.uv.os_homedir(),
            })[1] ~= nil
          end,
        },
      },
    },
  },
}
