return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-space>",
        accept_word = false, -- we'll add a custom mapping for this below
        accept_line = false,
        next = false,
        prev = false,
        dismiss = "<C-BS>",
      },
    },
    panel = { enabled = false },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
    vim.keymap.set(
      "i",
      "<S-space>",
      function() require("copilot.suggestion").accept_word() end,
      { desc = "Copilot Accept Word" }
    )
  end,
}
