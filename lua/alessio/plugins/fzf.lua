return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      on_create = function()
        local opts = { nowait = true, noremap = true, silent = true }
        -- Apply only to the current buffer
        local buf = vim.api.nvim_get_current_buf()
        vim.keymap.set("t", "<C-j>", "<Down>", opts)
        vim.keymap.set("t", "<C-k>", "<Up>", opts)
      end,
    },
  },
}
