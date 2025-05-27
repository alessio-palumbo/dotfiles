return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<leader>a",
        accept_word = false, -- we'll add a custom mapping for this below
        accept_line = false,
        next = false,
        prev = false,
        dismiss = "<leader>d",
      },
    },
    panel = { enabled = false },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
    vim.keymap.set(
      "i",
      "<leader>w",
      function() require("copilot.suggestion").accept_word() end,
      { desc = "Copilot Accept Word" }
    )
  end,
}
