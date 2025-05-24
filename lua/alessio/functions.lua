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
  local pos = vim.api.nvim_win_get_cursor(0) -- Get cursor position (row, col)
  local row, col = pos[1] - 1, pos[2]

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

  local opts = {
    relative = "win",
    row = row,
    col = col,
    width = #text,
    height = 1,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, false, opts)

  -- Close the floating window after 1 second
  vim.defer_fn(function()
    vim.api.nvim_win_close(win, true)
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

function M.delete_buffer()
  local nvimtree_open = require("nvim-tree.view").is_visible()
  local buftype = vim.bo.buftype
  local wins = vim.api.nvim_list_wins()
  local win_count = #wins
  local is_split = (win_count > 1 and not nvimtree_open) or (win_count > 2)

  -- Close buffer by type
  if buftype == "terminal" then
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

return M -- Return the module
