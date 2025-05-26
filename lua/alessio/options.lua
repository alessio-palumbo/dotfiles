local opt = vim.opt
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Line Numbers
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers

-- Indentation
opt.tabstop = 4 -- Number of spaces per tab
opt.softtabstop = 4 -- Number of spaces for <Tab> and <BS>
opt.shiftwidth = 4 -- Number of spaces per indentation level
opt.expandtab = true -- Convert tabs to spaces

-- Search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains uppercase

-- UI
opt.termguicolors = true -- Enable true color support
opt.cursorline = true -- Highlight the current line
opt.signcolumn = "yes" -- Always show the sign column

-- Splits
opt.splitright = true -- Split to the right
opt.splitbelow = true -- Split below

-- Undo and Backup
opt.undofile = true -- Save undo history
opt.backup = false -- Disable backup files
opt.writebackup = false -- Disable write backup
opt.swapfile = false -- Disable swap file

-- Indentation and White Space
opt.smartindent = true
opt.copyindent = true
opt.list = true
opt.listchars = "tab:> ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨"

-- Performance
opt.updatetime = 100 -- Smaller updatetime for CursorHold & CursorHoldI
opt.timeoutlen = 400 -- Faster key timeout

-- Scrolling
opt.scrolloff = 8 -- Keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns on the side

-- Misc
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support
opt.showmode = false -- Don't show mode in command line
opt.selection = "old" -- Exclude newline when selecting

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- Buffers
opt.title, opt.titlestring, opt.titlelen = true, "%<%F", 70 -- Set the title of the window to the filename

-- Highlighting
opt.syntax = "enable" -- Enable syntax highlighting
vim.api.nvim_set_hl(0, "Normal", { bg = "black", fg = "white" })
vim.api.nvim_set_hl(0, "Visual", { bg = "orange", fg = "RoyalBlue" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "DarkGrey", bold = true })
vim.api.nvim_set_hl(0, "MatchParen", { bg = "black", fg = "white", italic = true })

-- Git
if vim.fn.has("nvim") == 1 then vim.env.GIT_EDITOR = "nvr -cc split --remote-wait" end

-- Diagnostic
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    -- Optional: control highlight group mapping
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
  virtual_text = { source = true },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always", -- show "gopls", etc.
    header = "",
    prefix = "",
  },
})

-- Filetype configs

local filetype_indent = augroup("FiletypeIndent", { clear = true })

autocmd("FileType", {
  group = filetype_indent,
  pattern = { "json", "proto", "html", "css", "javascript" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

autocmd("FileType", {
  group = filetype_indent,
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.expandtab = false
  end,
})

autocmd({ "BufNewFile", "BufReadPost" }, {
  group = filetype_indent,
  pattern = { "*.yml", "*.yaml" },
  callback = function() vim.bo.filetype = "yaml" end,
})

-- YAML indentation settings
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_indent,
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
