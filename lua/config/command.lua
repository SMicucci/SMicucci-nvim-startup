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
  ---@diagnostic disable-next-line: param-type-mismatch
  if vim.fn.foldlevel('.') > 0 then
    ---@diagnostic disable-next-line: param-type-mismatch
    if vim.fn.foldclosed('.') ~= -1 then
      vim.cmd('normal! zo')
    else
      pcall(vim.cmd('normal! zc'))
      ---@diagnostic disable-next-line: param-type-mismatch
      if vim.fn.foldclosed('.') == vim.fn.line('.') then
        vim.cmd('normal! j')
      end
    end
  end
end, {
    desc = 'toggle fold element'
  })

-- TODO: end this command
M.cmd('Find',
  function (opts)
    -- help message or something
    if #opts.fargs == 0 then
      vim.notify('󰀦 Find require at least one argument\n',vim.log.levels.WARN)
      vim.notify('  input are used as regular expression directly',vim.log.levels.INFO)
      return
    end
    -- debug for now, ready to be thrown
    vim.notify(vim.inspect(opts.args), vim.log.levels.DEBUG)
    vim.notify(vim.inspect(opts.fargs), vim.log.levels.DEBUG)
    local regex
    for i, val in ipairs(opts.fargs) do
      if i == 1 then
        regex = val
      else
        regex = regex .. ' ' .. val
      end
    end
    print('result => ' .. vim.inspect(regex))
    local rg = vim.fn.executable('rg')
    local grep = vim.fn.executable('grep')
    if rg then
      -- run :grep with ripgrep
    elseif grep then
      vim.notify('󰀦 ripgrep not installed (recommended)',vim.log.levels.WARN)
      -- run :grep with grep
    else
      vim.notify('󰀦 grep not installed too',vim.log.levels.WARN)
      -- run :vimgrep
    end
    -- print(vim.inspect(rg_exist))
  end,
  {
    nargs = '*',
    desc = 'wrapper for :grep with \'rg\' or cascade to \'grep\' or \'vimgrep\''
  }
)

return M
