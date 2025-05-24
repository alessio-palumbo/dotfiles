local funcs = require("alessio.functions")
local map = vim.keymap.set

local function opts(desc, buf)
  local base = { noremap = true, silent = true }
  if desc then base.desc = desc end
  if buf then base.buffer = buf end
  return base
end

-- Home shortcuts
map("i", "jk", "<Esc>", opts())
map("t", "jk", "<C-\\><C-n>", opts())

-- Navigation shortcuts
map("i", "jj", "<Esc>o", opts()) -- Insert line below without changing mode
map("i", "<C-e>", "<C-o>A", opts()) -- Go to end of line in insert mode
map("i", "<A-l>", "<Esc>la", opts()) -- Move right in insert mode
map("n", "j", "gj", opts()) -- Move down without skipping wrapped lines
map("n", "k", "gk", opts()) -- Move up without skipping wrapped lines
map("n", "<leader>e", "<CR>", opts()) -- Alternative more ergonomic enter

-- Save and Quit shortcuts
map("i", "<C-s>", "<Esc>:w<CR>", opts()) -- Save
map("n", "<C-s>", ":w<CR>", opts()) -- Save
map("n", "<C-q>", ":q<CR>", opts()) -- Quit

-- Shortcuts to edit config files
map("n", "<leader>cf", ":e $MYVIMRC", opts())
map("n", "<leader>z", ":e $HOME/.zshrc", opts())

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts())
map("n", "<C-l>", "<C-w>l", opts())
map("n", "<C-j>", "<C-w>j", opts())
map("n", "<C-k>", "<C-w>k", opts())
map("i", "<C-h>", "<C-\\><C-N>C-w>h", opts())
map("i", "<C-l>", "<C-\\><C-N>C-w>l", opts())
map("i", "<C-j>", "<C-\\><C-N>C-w>j", opts())
map("i", "<C-k>", "<C-\\><C-N>C-w>k", opts())
map("t", "<C-h>", "<C-\\><C-N>C-w>h", opts())
map("t", "<C-l>", "<C-\\><C-N>C-w>l", opts())
map("t", "<C-j>", "<C-\\><C-N>C-w>j", opts())
map("t", "<C-k>", "<C-\\><C-N>C-w>k", opts())

map("n", "<leader>v", ":vs<CR>", opts())

-- Resize windows with arrow keys
map("n", "<A-h>", ":vertical resize -2<CR>", opts())
map("n", "<A-l>", ":vertical resize +2<CR>", opts())

-- Misc
map("n", "<CR>", ":nohlsearch", opts()) -- Clear highlights after search with enter
map("n", "*", ":keepjumps normal! mi*`i<CR>", opts()) -- Keeps the cursor under current word when searching

map("n", "<leader>p", '"0p', opts()) -- Paste last yanked register
map("v", "<leader>p", '"0p', opts()) -- Paste last yanked register

map("n", "<leader>n", "o<Esc>", opts()) -- Insert new line below in normal mode

map("n", "<leader>ww", ":FixWhitespace<CR>", opts()) -- Clear whitespace (requires plugin)

map("n", "<leader>u", funcs.gen_uuid, opts("Insert UUID"))

map("n", "<leader>x", funcs.convert_hex_word_to_decimal, opts())

-- Move selected text up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts())
map("v", "K", ":m '<-2<CR>gv=gv", opts())

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts())
map("n", "<C-u>", "<C-u>zz", opts())
map("n", "n", "nzzzv", opts())
map("n", "N", "Nzzzv", opts())

-- Buffers delete
vim.keymap.set("n", "<leader>q", funcs.delete_buffer, opts())
vim.keymap.set("n", "<leader>!q", ":Bdelete!<CR>", opts())
vim.keymap.set("t", "jkq", function()
  vim.cmd("stopinsert")
  funcs.delete_buffer()
end, opts())

-- Buffers navigation
vim.keymap.set("n", "gb", funcs.go_back_and_close, opts("Go back and close previous buffer if unchanged"))

-- In terminal mode: <C-^> to switch to alternate buffer
vim.keymap.set("t", "<C-^>", [[<C-\><C-n>:b#<CR>]], opts("Switch to previous buffer"))

-- Comments - remap neovim native mappings
vim.keymap.set("n", "cm", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("x", "cm", "gc", { remap = true, desc = "Toggle comment" })

-- Diagnostic
map("n", "<leader>d", vim.diagnostic.open_float, opts("Show line diagnostics"))
map("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
map("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))

-- #######################
-- ### Plugins Keymaps ###
-- #######################

-- ### Bufferline ###

for i = 1, 9 do
  -- Jump to buffer 1-9 with <leader>1 to <leader>9
  vim.keymap.set(
    "n",
    "<Leader>" .. i,
    function() require("bufferline").go_to_buffer(i, true) end,
    { desc = "Go to buffer " .. i }
  )

  -- Delete buffers with <BS>1 .. <BS>9
  vim.keymap.set("n", "<BS>" .. i, function() vim.cmd("bdelete " .. i) end, { desc = "Delete buffer " .. i })
end

-- <leader>0 goes to buffer 10
vim.keymap.set(
  "n",
  "<Leader>0",
  function() require("bufferline").go_to_buffer(10, true) end,
  { desc = "Go to buffer 10" }
)

-- <BS>0 deletes buffer 10
vim.keymap.set("n", "<BS>0", function() vim.cmd("bdelete 10") end, { desc = "Delete buffer 10" })

-- Navigate through buffers
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})

-- #######################
--
-- ### NvimTree ###

vim.keymap.set("n", "<C-b>", function() require("nvim-tree.api").tree.toggle() end, { desc = "Toggle NvimTree" })

-- #######################
--
-- ### Fzf ###

local fzf = require("fzf-lua")

map("n", "ff", fzf.files, opts("Find files"))
map("n", "fh", function() fzf.files({ cwd = os.getenv("HOME") }) end, opts())
map("n", "fr", function() fzf.files({ cwd = "/" }) end, opts())
map("n", "fp", function()
  local root = funcs.git_root()
  if root then
    fzf.files({ cwd = root })
  else
    fzf.files()
  end
end, opts())

-- Grep inside Git root or current dir
map("n", "fg", function()
  local cmd = fzf.live_grep_native or fzf.live_grep
  cmd({ cwd = funcs.git_root() or vim.loop.cwd() })
end, opts())

map("n", "fi", function()
  local dir = vim.fn.input("Search in dir: ", "", "dir")
  if dir ~= "" then fzf.live_grep({ cwd = dir }) end
end, opts())

map("n", "<leader>fb", fzf.buffers, opts("Find buffer"))
map("n", "<leader>fo", fzf.oldfiles, opts("Recent files"))
map("n", "<leader>fw", fzf.grep_cword, opts("Grep current word"))
map("n", "<leader>fp", fzf.grep_project, opts("Grep project"))

-- Git-related commands
map("n", "<leader>fc", fzf.git_commits, opts("Git commits"))
map("n", "<leader>fb", fzf.git_bcommits, opts("Git buffer commits"))
map("n", "<leader>fs", fzf.git_status, opts("Git status"))

-- #######################
--
-- ### Lsp ###

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    map("n", "gr", vim.lsp.buf.references, opts("Show LSP references", ev.buf))
    map("n", "gd", vim.lsp.buf.definition, opts("Go to definition", ev.buf))
    map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration", ev.buf))
    map("n", "gi", vim.lsp.buf.implementation, opts("Show LSP implementations", ev.buf))
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Show type definition", ev.buf))
    map("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help", ev.buf))
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("See available code actions", ev.buf))
    map("n", "<leader>rn", vim.lsp.buf.rename, opts("Smart rename", ev.buf))
    map("n", "<leader>d", vim.diagnostic.open_float, opts("Show line diagnostics", ev.buf))
    map("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic", ev.buf))
    map("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic", ev.buf))
    map("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor", ev.buf))
  end,
})
