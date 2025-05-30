local M = {}

-- Generate a UUID and insert it at the cursor position
function M.gen_uuid()
  -- Check if 'uuidgen' exists
  local exists = vim.fn.system("command -v uuidgen")
  if not exists:match("%w+") then
    print("command not found: uuidgen")
    return
  end

  -- Generate UUID and convert to lowercase
  local uuid = vim.fn.system("uuidgen | tr '[A-Z]' '[a-z]'"):gsub("\n", "")

  -- Insert at cursor position
  vim.api.nvim_put({ uuid }, "c", true, true)
end

-- Function to show a floating tooltip
function M.show_tooltip(text)
  local width = vim.fn.strdisplaywidth(text)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

  local opts = {
    relative = "cursor", -- position relative to the cursor
    row = 1, -- show tooltip just below the cursor
    col = 0,
    width = width,
    height = 1,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, false, opts)

  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, 1000)
end

-- Function to convert a hex word to decimal and show it in a tooltip
function M.convert_hex_word_to_decimal()
  local word = vim.fn.expand("<cword>") -- Get the word under the cursor

  if word:sub(1, 2) == "0x" then
    local hex_part = word:sub(3) -- Remove '0x' prefix
    local decimal_value = tonumber(hex_part, 16) -- Convert hex to decimal
    if decimal_value then
      M.show_tooltip("Decimal: " .. decimal_value)
    else
      M.show_tooltip("Invalid hex number")
    end
  else
    M.show_tooltip("Not a valid hex word: " .. word)
  end
end

local function is_fzf_lua_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "fzf" then return true end
  end
  return false
end

function M.delete_buffer()
  local nvimtree_open = require("nvim-tree.view").is_visible()
  local buftype = vim.bo.buftype
  local wins = vim.api.nvim_list_wins()
  local win_count = #wins
  local is_split = (win_count > 1 and not nvimtree_open) or (win_count > 2)

  -- Close buffer by type
  if is_fzf_lua_open() then
    -- Simulate pressing Esc to dismiss FZF
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  elseif buftype == "terminal" then
    vim.cmd("Bdelete!")
  elseif not is_split then
    vim.cmd("Bdelete")
  end

  -- Close window if needed
  local listed_bufs = vim.fn.getbufinfo({ buflisted = 1 }) -- fetch after Bdelete
  if is_split then
    vim.cmd("q")
  elseif listed_bufs == nil or #listed_bufs == 0 then
    vim.cmd("q")
  end
end

function M.git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if handle then
    local result = handle:read("*a"):gsub("\n", "")
    handle:close()
    return result ~= "" and result or nil
  end
end

function M.go_back_and_close()
  local prev_buf = vim.api.nvim_get_current_buf()
  vim.cmd([[execute "normal! \<c-o>"]])
  local curr_buf = vim.api.nvim_get_current_buf()

  if curr_buf ~= prev_buf then
    local bufinfo = vim.fn.getbufinfo(prev_buf)
    if bufinfo and bufinfo[1] and bufinfo[1].changed == 0 then
      -- use a safer way to check buffer validity before deleting
      if vim.api.nvim_buf_is_loaded(prev_buf) and vim.api.nvim_buf_is_valid(prev_buf) then
        vim.cmd("bd " .. prev_buf)
      end
    end
  end
end

local function move_to_struct_end(node)
  local struct_node = node:field("type")[1]
  if struct_node and struct_node:type() == "struct_type" then
    local node_end_ln, _, _ = struct_node:end_()
    vim.api.nvim_win_set_cursor(0, { node_end_ln + 1, 0 })
    return true
  end
end

function M.move_to_struct_end()
  local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  while node do
    if node:type() == "type_declaration" then
      for child in node:iter_children() do
        if child:type() == "type_spec" then return move_to_struct_end(child) end
      end
    end
    if node:type() == "type_spec" then return move_to_struct_end(node) end
    node = node:parent()
  end
  return false
end

function M.go_test_func_under_cursor()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == "function_declaration" then
      local name_node = node:field("name")[1]
      if name_node then
        local func_name = vim.treesitter.get_node_text(name_node, 0)
        if func_name:match("^Test") then
          local cmd = "go test -run '^" .. func_name .. "$'"
          vim.cmd("!" .. cmd)
        else
          vim.notify("Not a test function (name doesn't start with 'Test')", vim.log.levels.WARN)
        end
        return
      end
    end
    node = node:parent()
  end
  vim.notify("No enclosing test function found", vim.log.levels.WARN)
end

function M.terminal_in_lcd(split)
  local dir = vim.fn.expand("%:p:h")
  local term_cmd = "term://zsh"
  if dir ~= "" then term_cmd = "term://" .. dir .. "//zsh" end
  if split then
    vim.cmd("split " .. term_cmd)
    vim.cmd("resize 15")
  else
    vim.cmd("edit " .. term_cmd)
  end
end

return M
