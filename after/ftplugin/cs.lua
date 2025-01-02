local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2

-- vim.g.dotnet_show_project_file = false
vim.cmd('compiler dotnet')
set.makeprg = "dotnet build --nologo"
