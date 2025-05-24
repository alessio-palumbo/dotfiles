return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      on_create = function()
        local opts = { nowait = true, noremap = true, silent = true }
        vim.keymap.set("t", "<C-j>", "<Down>", opts)
        vim.keymap.set("t", "<C-k>", "<Up>", opts)
      end,
    },
    keymap = {
      builtin = {
        ["<S-j>"] = "preview-page-down",
        ["<S-k>"] = "preview-page-up",
      },
    },
  },
}
