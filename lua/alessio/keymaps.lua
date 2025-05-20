local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local funcs = require("alessio.functions")

-- Home shortcuts
map("i", "jk", "<Esc>", opts)
map("t", "jk", "<C-\\><C-n>", opts)

-- Navigation shortcuts
map("i", "jj", "<Esc>o", opts)    -- Insert line below without changing mode
map("i", "<C-e>", "<C-o>A", opts) -- Go to end of line in insert mode
map("i", "<A-l>", "<Esc>la", opts) -- Move right in insert mode
map("n", "j", "gj", opts)         -- Move down without skipping wrapped lines
map("n", "k", "gk", opts)         -- Move up without skipping wrapped lines

-- Save and Quit shortcuts
map("i", "<C-s>", "<Esc>:w<CR>", opts)  -- Save
map("n", "<C-s>", ":w<CR>", opts)       -- Save
map("n", "<C-q>", ":q<CR>", opts)       -- Quit

-- Shortcuts to edit config files
map("n", "<leader>cf", ":e $MYVIMRC", opts)
map("n", "<leader>z", ":e $HOME/.zshrc", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("i", "<C-h>", "<C-\\><C-N>C-w>h", opts)
map("i", "<C-l>", "<C-\\><C-N>C-w>l", opts)
map("i", "<C-j>", "<C-\\><C-N>C-w>j", opts)
map("i", "<C-k>", "<C-\\><C-N>C-w>k", opts)
map("t", "<C-h>", "<C-\\><C-N>C-w>h", opts)
map("t", "<C-l>", "<C-\\><C-N>C-w>l", opts)
map("t", "<C-j>", "<C-\\><C-N>C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N>C-w>k", opts)

map("n", "<leader>v", ":vs<CR>", opts)

-- Resize windows with arrow keys
map("n", "<A-h>", ":vertical resize -2<CR>", opts)
map("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Misc
map("n", "<CR>", ":nohlsearch", opts)   -- Clear highlights after search with enter
map("n", "*", ":keepjumps normal! mi*`i<CR>", opts) -- Keeps the cursor under current word when searching

map("n", "<leader>p", "\"0p", opts)     -- Paste last yanked register
map("v", "<leader>p", "\"0p", opts)     -- Paste last yanked register

map("n", "<leader>n", "o<Esc>", opts)   -- Insert new line below in normal mode

map("n", "<leader>ww", ":FixWhitespace<CR>", opts)   -- Clear whitespace (requires plugin)

map("n", "<leader>u", funcs.gen_uuid, { silent = true, desc = "Insert UUID" })

map("n", "<leader>x", funcs.convert_hex_word_to_decimal, { silent = true })

-- Move selected text up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Buffers delete 
vim.keymap.set("n", "<leader>q", funcs.delete_buffer, opts)
vim.keymap.set("n", "<leader>!q", ":Bdelete!<CR>", opts)
vim.keymap.set("t", "jkq", function() vim.cmd("stopinsert") funcs.delete_buffer() end, opts)

-- In terminal mode: <C-^> to switch to alternate buffer
vim.keymap.set("t", "<C-^>", [[<C-\><C-n>:b#<CR>]], { silent = true, desc = "Switch to previous buffer" })

-- #######################
-- ### Plugins Keymaps ###
-- #######################

-- ### Bufferline ###

for i = 1, 9 do
  -- Jump to buffer 1-9 with <leader>1 to <leader>9
  vim.keymap.set("n", "<Leader>" .. i, function()
    require("bufferline").go_to_buffer(i, true)
  end, { desc = "Go to buffer " .. i })

  -- Delete buffers with <BS>1 .. <BS>9
  vim.keymap.set("n", "<BS>" .. i, function()
    vim.cmd("bdelete " .. i)
  end, { desc = "Delete buffer " .. i })
end

-- <leader>0 goes to buffer 10
vim.keymap.set("n", "<Leader>0", function() require("bufferline").go_to_buffer(10, true) end, { desc = "Go to buffer 10" })
-- <BS>0 deletes buffer 10
vim.keymap.set("n", "<BS>0", function() vim.cmd("bdelete 10") end, { desc = "Delete buffer 10" })

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

-- #######################
--
-- ### NvimTree ###

vim.keymap.set('n', '<C-b>', function() require("nvim-tree.api").tree.toggle() end, { desc = "Toggle NvimTree" })

-- #######################
--
-- ### Fzf ###

local fzf = require("fzf-lua")

map("n", "ff", fzf.files, opts)
map("n", "fh", function() fzf.files({ cwd = os.getenv("HOME") }) end, opts)
map("n", "fr", function() fzf.files({ cwd = "/" }) end, opts)
map("n", "fp", function()
  local root = funcs.git_root()
  if root then fzf.files({ cwd = root }) else fzf.files() end
end, opts)

-- Grep inside Git root or current dir
map("n", "fg", function()
  fzf.live_grep({ cwd = funcs.git_root() or vim.loop.cwd() })
end, opts)

map("n", "fi", function()
  local dir = vim.fn.input("Search in dir: ", "", "dir")
  if dir ~= "" then fzf.live_grep({ cwd = dir }) end
end, opts)

-- Git-related commands
map("n", "fc", fzf.git_commits, opts)
map("n", "fb", fzf.git_bcommits, opts)
map("n", "fs", fzf.git_status, opts)
