return {
  "numToStr/Comment.nvim",
  opts = {
    ---Add your custom mappings here
    mappings = {
      basic = false, -- disable default `gcc`, `gc`
      extra = false, -- disable extra mappings like `gco`, `gcO`, `gcA`
    },
    ---You can add more config here if needed
  },
  config = function(_, opts)
    require("Comment").setup(opts)

    -- Custom mappings
    vim.keymap.set("n", "cm", require("Comment.api").toggle.linewise.current, { desc = "Toggle comment" })
    vim.keymap.set("v", "cm", function()
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end, { desc = "Toggle comment", expr = false })
  end,
}
