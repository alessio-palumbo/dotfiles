return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "go", "markdown", "vim", "bash" },
      highlight = { enable = true },
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "lua",
        "go",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "c",
        "bash",
        "json",
        "javascript",
        "yaml",
        "html",
        "css",
        "dockerfile",
        "gitignore",
        "query",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end
}
