local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2

set.makeprg = 'dotnet build'
set.errorformat = table.concat({
  '%E%f(%l\\,%c): error %m',
  '%W%f(%l\\,%c): warning %m',
  '%C%m',
  '%-G%.%#',
}, ',')
