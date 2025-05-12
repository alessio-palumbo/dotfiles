return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local function is_readonly()
      return vim.bo.readonly and "" or ""
    end

    local function is_modified()
      return vim.bo.modified and "●" or ""
    end

    local function filetype_with_icon()
      if vim.fn.winwidth(0) <= 70 then return "" end
      local icon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype) or ""
      local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "no ft"
      return ft .. " " .. icon
    end

    local function fileformat_with_icon()
      if vim.fn.winwidth(0) <= 70 then return "" end
      local format = vim.bo.fileformat
      local icons = { unix = "", dos = "", mac = "" }
      return format .. " " .. (icons[format] or "")
    end

    lualine.setup({
      options = {
        theme = "tokyonight",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = { "mode", "paste" },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = { is_readonly, "filename", is_modified },
        lualine_x = { fileformat_with_icon, filetype_with_icon },
        lualine_y = {},
        lualine_z = { "location" }
      },
      tabline = {
        lualine_a = { "buffers" },
        lualine_z = { "tabs" },
      },
      extensions = { "fugitive", "nvim-tree" },
    })
  end
}
