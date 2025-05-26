return {
  "olexsmir/gopher.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap", -- optional, for debugging
  },
  "olexsmir/gopher.nvim",
  -- branch = "develop"
  -- (optional) will update plugin's deps on every update
  build = function() vim.cmd.GoInstallDeps() end,
}
