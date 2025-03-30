local opt = vim.opt

-- Line Numbers
opt.number = true         -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers

-- Indentation
opt.tabstop = 4           -- Number of spaces per tab
opt.softtabstop = 4       -- Number of spaces for <Tab> and <BS>
opt.shiftwidth = 4        -- Number of spaces per indentation level
opt.expandtab = true      -- Convert tabs to spaces

-- Search
opt.ignorecase = true     -- Ignore case in search patterns
opt.smartcase = true      -- Override ignorecase if search contains uppercase

-- UI
opt.termguicolors = true  -- Enable true color support
opt.cursorline = true     -- Highlight the current line
opt.signcolumn = "yes"    -- Always show the sign column

-- Splits
opt.splitright = true     -- Split to the right
opt.splitbelow = true     -- Split below

-- Undo and Backup
opt.undofile = true       -- Save undo history
opt.backup = false        -- Disable backup files
opt.writebackup = false   -- Disable write backup
opt.swapfile = false      -- Disable swap file

-- Indentation and White Space
opt.smartindent = true
opt.list = true
opt.listchars = "tab:> ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨"

-- Performance
opt.updatetime = 100          -- Smaller updatetime for CursorHold & CursorHoldI
opt.timeoutlen = 400          -- Faster key timeout

-- Scrolling
opt.scrolloff = 8             -- Keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8         -- Keep 8 columns on the side

-- Misc
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a"           -- Enable mouse support
opt.showmode = false:     -- Don't show mode in command line
opt.selection = "old"     -- Exclude newline when selecting
set foldlevel=99          -- Open all folds by default

-- Buffers
opt.title, opt.titlestring, opt.titlelen = true, "%<%F", 70 -- Set the title of the window to the filename

-- Theme
opt.syntax = "enable"    -- Enable syntax highlighting
opt.colorscheme = "molokai" -- Set colorscheme
opt.highlight = "Normal guibg=black guifg=white"

-- Highlighting
vim.api.nvim_set_hl(0, "Normal", { bg = "black", fg = "white" })
vim.api.nvim_set_hl(0, "Visual", { bg = "orange", fg = "RoyalBlue" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "DarkGrey", bold = true })
vim.api.nvim_set_hl(0, "MatchParen", { bg = "black", fg = "white", italic = true })

-- Git
if vim.fn.has('nvim') == 1 then
  vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'
end
