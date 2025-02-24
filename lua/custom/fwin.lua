---generate a floating window under the cursor
---@param width number window width in char
---@param height number window height in char
---@param title? string window title (optional)
---@return number window window number
local function cursor_floating_window(width, height, title)
  title = title or ''
  local buf = vim.api.nvim_create_buf(false, true)
  local win_opts = {
    relative = 'cursor',
    width = width,
    height = height,
    anchor = 'NW',
    row = 1,
    col = 0,
    style = 'minimal',
    border = 'rounded',
    noautocmd = true,
    winhighlight = 'FloatTitle:IncSearch'
  }
  if title ~= '' then
    win_opts.title = title
    win_opts.title_pos = 'center'
  end
  local win = vim.api.nvim_open_win(buf, false, win_opts )
  -- vim.api.nvim_win_set_config(win,)
  return win
end

local win = cursor_floating_window(20,4, 'Code Action')
local buf = vim.api.nvim_win_get_buf(win)
vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
  "floating window!",
  "",
  "",
  "('q' for exit)"
})

