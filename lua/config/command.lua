local M = {}
M.au = vim.api.nvim_create_autocmd
M.aug = vim.api.nvim_create_augroup
M.cmd = vim.api.nvim_create_user_command

local terminal = M.aug('terminal',{clear = true, })
M.au('termopen', {
  group = terminal,
  callback = function ()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
  end,
  desc = 'configure options for terminal'
})

M.cmd('FoldToggle',function ()
  if vim.fn.foldclosed('.') ~= -1 then
    vim.cmd('normal! zo')
  else
    vim.cmd('normal! zc')
    if vim.fn.foldclosed('.') == vim.fn.line('.') then
      vim.cmd('normal! j')
    end
  end
end,{
    desc = 'toggle fold element'
  }
)

-- wrapper for :grep with 'rg' or cascade to 'grep' or 'vimgrep'
-- TODO: end this command
M.cmd('Find', function (opts)
  -- grep can't search nothing
  if #opts.fargs == 0 then
    vim.notify('Find require at least one word to grep into work directory',vim.log.levels.WARN)
    return
  end
  -- debug for now, ready to be thrown
  vim.notify(vim.inspect(opts), vim.log.levels.DEBUG)
  local regex
  for i, val in ipairs(opts.fargs) do
    if i == 1 then
      regex = val
    else
      regex = regex .. '\\ ' .. val
    end
  end
  print(regex)
end, {
    nargs = '*',
    desc = 'wrapper for :grep with \'rg\' or cascade to \'grep\' or \'vimgrep\''
  }
)

return M
