return {
  "stevearc/conform.nvim",
  events = { "BufWritePre" },
  config = function()
    local conform = require("conform")
    local custom_timeout = 4000

    conform.setup({
      formatters = {
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--collapse-simple-statement",
            "Always",
          },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        rust = { "rustfmt" },
        javascript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        ["*"] = { "codespell", "trim_whitespace" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = custom_timeout,
      },
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>f",
      function()
        conform.format({
          lsp_format = "fallback",
          async = false,
          timeout_ms = custom_timeout,
        })
      end,
      { desc = "Format file or range (in visual mode)" }
    )
  end,
}
