return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go", -- Go-specific DAP config
  },
  ft = "go",
  config = function()
    require("dap-go").setup()
    local dap = require("dap")
    local dapui = require("dapui")

    local dap_mappings = {
      { "c", dap.continue, desc = "Continue" },
      { "n", dap.step_over, desc = "Step Over" },
      { "i", dap.step_into, desc = "Step Into" },
      { "o", dap.step_out, desc = "Step Out" },
      { "b", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
      { "r", dap.repl.open, desc = "Open REPL" },
      {
        "q",
        function()
          dap.terminate()
          dapui.close()
        end,
        desc = "Quit Debug",
      },
    }

    -- Apply these mappings only when debugging starts
    dap.listeners.after.event_initialized["dap_keymaps"] = function()
      for _, map in ipairs(dap_mappings) do
        vim.keymap.set("n", map[1], map[2], { desc = map.desc })
      end
    end

    -- Clean them up when debugging ends
    local function unregister_dap_keys()
      for _, map in ipairs(dap_mappings) do
        vim.keymap.del("n", map[1])
      end
    end

    dap.listeners.after.event_terminated["dap_keymaps"] = unregister_dap_keys
    dap.listeners.after.event_exited["dap_keymaps"] = unregister_dap_keys
  end,
}
