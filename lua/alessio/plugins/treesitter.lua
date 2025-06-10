return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 3,
    })
    require("nvim-treesitter.configs").setup({
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
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            ["ao"] = "@block.outer", -- Select outer block (e.g., entire function or object)
            ["io"] = "@block.inner", -- Select inner block
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          },
        },
      },
    })
  end,
}
