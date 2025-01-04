local au = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command

-- terminal configuration made by autocommand
au('termopen', {
  callback = function ()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
  end,
  desc = 'configure options for terminal'
})

-- wrapper for :grep with 'rg' or cascade to 'grep' or 'vimgrep'
cmd('Find', function (opts)
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
end, { nargs = '*', desc = 'wrapper for :grep with \'rg\' or cascade to \'grep\' or \'vimgrep\'' })
