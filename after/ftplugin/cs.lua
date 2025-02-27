local set = vim.opt_local
local command = require('config.command')

-- set.shiftwidth = 2
-- set.tabstop = 2

-- vim.g.dotnet_show_project_file = false
vim.cmd('compiler dotnet')
set.makeprg = "dotnet build -c Debug -p:NoLogo=true"

local cs = command.aug("C#", {clear = true})
command.au("QuickFixCmdPre", {
  pattern = "cs",
  callback = function ()
    vim.cmd("!dotnet clean")
  end,
  group = cs,
  desc = "clean project before build"
})
