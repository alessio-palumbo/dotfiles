return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      numbers = function(opts)
        -- Superscript Unicode digits
        local sup = { "⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹" }
        local n = tostring(opts.ordinal)
        local result = ""
        for i = 1, #n do
          local digit = tonumber(n:sub(i, i))
          result = result .. (sup[digit + 1] or "")
        end
        return result
      end,
      show_buffer_close_icons = true,
      show_close_icon = false,
      diagnostics = "nvim_lsp",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      color_icons = true, -- uses devicons
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true, -- shows a line between bufferline and tree
        },
      },
    },
  },
}
