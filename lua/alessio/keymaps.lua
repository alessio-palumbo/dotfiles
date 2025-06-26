local funcs = require("alessio.functions")
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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
map("i", "jj", "<Esc>o", opts("Insert on line below"))
map("i", "<C-e>", "<C-o>A", opts("Go to end of line"))
map("i", "<A-l>", "<Esc>la", opts("Move right"))
map("n", "j", "gj", opts("Move down wrapped"))
map("n", "k", "gk", opts("Move up wrapped"))

-- Save and Quit shortcuts
map("i", "<C-s>", "<Esc>:w<CR>", opts("Save buffer"))
map("n", "<C-s>", ":w<CR>", opts("Save buffer"))
map("n", "<C-q>", ":q<CR>", opts("Quit"))

-- Shortcuts to edit config files
map("n", "<leader>cf", ":e $MYVIMRC", opts())
map("n", "<leader>z", ":e $HOME/.zshrc", opts())

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts())
map("n", "<C-l>", "<C-w>l", opts())
map("n", "<C-j>", "<C-w>j", opts())
map("n", "<C-k>", "<C-w>k", opts())
map("t", "<C-h>", "<C-\\><C-N>C-w>h", opts())
map("t", "<C-l>", "<C-\\><C-N>C-w>l", opts())
map("t", "<C-j>", "<C-\\><C-N>C-w>j", opts())
map("t", "<C-k>", "<C-\\><C-N>C-w>k", opts())

map("n", "<leader>v", ":vs<CR>", opts("Split vertically"))

-- Resize windows with arrow keys
map("n", "<A-h>", ":vertical resize -2<CR>", opts("Vertical resize -2"))
map("n", "<A-l>", ":vertical resize +2<CR>", opts("Vertical resize +2"))

-- Misc
map("n", "<CR>", ":nohlsearch<CR>", opts("Clear highlighting"))
map("n", "*", ":keepjumps normal! mi*`i<CR>", opts("Keeps the cursor under current word when searching"))
map({ "n", "v" }, "<leader>p", '"0p', opts("Paste last yanked"))
map("n", "<leader>n", "o<Esc>", opts("Insert new line"))
map("n", "<leader>ww", ":FixWhitespace<CR>", opts("Clear whitespace"))

map("n", "<leader>u", funcs.gen_uuid, opts("Insert UUID"))
map("n", "<leader>x", funcs.convert_hex_word_to_decimal, opts("Convert hex word to decimal"))

-- Move selected text up/down
map("v", "J", ":m '>+1<CR>gv=gv", opts("Move selected text down"))
map("v", "K", ":m '<-2<CR>gv=gv", opts())

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts())
map("n", "<C-u>", "<C-u>zz", opts())
map("n", "n", "nzzzv", opts())
map("n", "N", "Nzzzv", opts())

-- Buffers delete
map("n", "<leader>q", funcs.delete_buffer, opts())
map("n", "<leader>!q", ":Bdelete!<CR>", opts())
map("t", "jkq", function()
  vim.cmd("stopinsert")
  funcs.delete_buffer()
end, opts())

-- Buffers navigation
map("n", "gb", funcs.go_back_and_close, opts("Go back and close previous buffer if unchanged"))

-- Comments - remap neovim native mappings
map("n", "cm", "gcc", { remap = true, desc = "Toggle comment" })
map("x", "cm", "gc", { remap = true, desc = "Toggle comment" })

-- Diagnostic
map("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
map("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))

-- Terminal
map("t", "<C-^>", [[<C-\><C-n>:b#<CR>]], opts("Switch to previous buffer"))
map("t", "<Esc>", [[<C-\><C-n>]], opts("Escape to normal mode"))
map("n", "<leader>tt", [[<C-\><C-n>]], opts("Escape to normal mode"))
map("n", "ts", function() funcs.terminal_in_lcd(true) end, opts("Terminal split in current dir"))
map("n", "tt", function() funcs.terminal_in_lcd(false) end, opts("Terminal in new buffer"))

-- Spellcheck
map("n", "<leader>l", function()
  if vim.o.spell then
    vim.opt.spell = false
  else
    vim.opt.spell = true
    vim.opt.spelllang = "en_au"
  end
end, opts("Toggle spell check (en_au)"))

-- Search and replace helper
vim.keymap.set("v", "<leader>r", ":s/", { noremap = true, silent = false })

-- #######################
-- ### Plugins Keymaps ###
-- #######################

-- ### Bufferline ###

local bufferline = require("bufferline")
for i = 1, 9 do
  -- Jump to buffer 1-9 with <leader>1 to <leader>9
  map("n", "<Leader>" .. i, function() bufferline.go_to_buffer(i, true) end, opts("Go to buffer " .. i))
  -- Delete buffers with <BS>1 .. <BS>9
  map("n", "<BS>" .. i, function()
    bufferline.exec(i, function(buf) vim.cmd("Bdelete " .. buf.id) end)
  end, opts("Delete buffer at position " .. i))
end

-- <leader>0 goes to buffer 10
map("n", "<Leader>0", function() bufferline.go_to_buffer(10, true) end, opts("Go to buffer 10"))
-- <BS>0 deletes buffer 10
map("n", "<BS>0", function()
  bufferline.exec(10, function(buf) vim.cmd("Bdelete " .. buf.id) end)
end, opts("Delete buffer at position 10"))

-- Navigate through buffers
map("n", "<Tab>", function() bufferline.cycle(1) end, opts("Next buffer"))
map("n", "<S-Tab>", function() bufferline.cycle(-1) end, opts("Prev buffer"))

-- #######################
--
-- ### NvimTree ###

map("n", "<C-b>", function() require("nvim-tree.api").tree.toggle() end, { desc = "Toggle NvimTree" })

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
  local rgopts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --fixed-strings"
  cmd({ cwd = funcs.git_root() or vim.loop.cwd(), rg_opts = rgopts })
end, opts())

map("n", "fi", function()
  local dir = vim.fn.input("Search in dir: ", "", "dir")
  local rgopts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --fixed-strings"
  if dir ~= "" then fzf.live_grep({ cwd = dir, rg_opts = rgopts }) end
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

autocmd("LspAttach", {
  group = augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    map("n", "gr", vim.lsp.buf.references, opts("Show LSP references", ev.buf))
    map("n", "gd", vim.lsp.buf.definition, opts("Go to definition", ev.buf))
    map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration", ev.buf))
    map("n", "gi", vim.lsp.buf.implementation, opts("Show LSP implementations", ev.buf))
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Show type definition", ev.buf))
    map("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help", ev.buf))
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("See available code actions", ev.buf))
    map("n", "<leader>rn", vim.lsp.buf.rename, opts("Smart rename", ev.buf))
    map("n", "K", vim.lsp.buf.hover, opts("Show documentation for what is under cursor", ev.buf))
  end,
})

-- #######################
--
-- ### Flash ###

local flash = require("flash")

map({ "n", "x", "o" }, "<leader>s", function() flash.jump() end, opts("Flash jump"))
map({ "n", "x", "o" }, "<leader>S", function() flash.treesitter() end, opts("Flash Treesitter"))
map("o", "r", function() flash.remote() end, opts("Remote Flash"))
map("c", "<C-s>", function() flash.toggle() end, opts("Toggle Flash Search"))

-- #######################
--
-- ### Gitsigns ###

local gitsigns = require("gitsigns")
map("n", "]h", gitsigns.next_hunk, { desc = "Next Git hunk" })
map("n", "[h", gitsigns.prev_hunk, { desc = "Prev Git hunk" })
map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })

-- #######################
--
-- ### Go - Gopher ###
--
autocmd("FileType", {
  group = augroup("GoGopherConfig", { clear = true }),
  pattern = "go",
  callback = function(ev)
    -- Alternate between test and implementation
    map("n", "ga", function()
      local file = vim.api.nvim_buf_get_name(0)
      if file:match("_test%.go$") then
        file = file:gsub("_test%.go$", ".go")
      else
        file = file:gsub("%.go$", "_test.go")
      end
      vim.cmd("edit " .. file)
    end, opts("Go: Alternate file", ev.buf))

    local gopher = require("gopher")
    -- Gopher tag mappings
    map("n", "<leader>ta", function() gopher.tags.add("json") end, opts("Go: Add JSON tags", ev.buf))
    map("n", "<leader>tr", function() gopher.tags.rm("json") end, opts("Go: Remove JSON tags", ev.buf))
    map("n", "<leader>gt", gopher.test.add, opts("Go: Add test for function", ev.buf))
    map("n", "<leader>if", gopher.iferr, opts("Go: Add if err stub", ev.buf))
    map("n", "<leader>im", function()
      -- Handle bug in gopher goimpl that inserts interface inside struct.
      if funcs.move_to_struct_end() then
        vim.ui.input({ prompt = "Go interface to implement: " }, function(interface)
          if interface and interface ~= "" then
            gopher.impl(interface)
          else
            vim.notify("No interface provided", vim.log.levels.WARN)
          end
        end)
      end
      vim.notify("No struct found under cursor", vim.log.levels.ERROR)
    end, opts("Go: Implement interface", ev.buf))

    map("n", "<leader>tf", funcs.go_test_func_under_cursor, opts("Go: Run test under cursor", ev.buf))
  end,
})

-- #######################
--
-- ### Dap ###

autocmd("FileType", {
  group = augroup("DapConfig", { clear = true }),
  pattern = "go",
  callback = function(ev)
    local dap = require("dap")
    map("n", "<leader>ds", function() dap.continue() end, opts("Start/Continue Debugging", ev.buffer))
    map("n", "<leader>de", function() dap.terminate() end, { desc = "Terminate" })
    map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    map("n", "<leader>dt", function() require("dap-go").debug_test() end, { desc = "Debug Nearest Test" })
  end,
})

autocmd("FileType", {
  group = augroup("QuickfixConfig", { clear = true }),
  pattern = "qf",
  callback = function(ev)
    map("n", "<CR>", "<CR>", opts("Use enter to open quickfix file", ev.buffer))
    map("n", "<Esc>", ":cclose<CR>", opts("Use enter to open quickfix file", ev.buffer))
  end,
})

-- #######################
--
-- ### Tmux Navigator ###

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts())
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts())
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts())
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts())
