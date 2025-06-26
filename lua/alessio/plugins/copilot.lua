return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    suggestion = {
      auto_trigger = false,
      keymap = {
        accept = "<C-space>",
        accept_word = false, -- we'll add a custom mapping for this below
        accept_line = false,
        next = false,
        prev = false,
        dismiss = false,
      },
    },
    panel = { enabled = false },
  },
}
