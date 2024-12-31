local set = vim.opt

set.mousehide = true
set.showtabline = 2
set.number = true
set.relativenumber = true
set.syntax = 'on'
set.termguicolors = true
set.wildmenu = true
set.wildoptions = 'pum'
set.wildmode = 'full'
-- tabs in vim => #3
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
vim.cmd '%retab!'

--[[
copied text stay in register '+'
selected text (linux) stay in register '*'
(yes, isn't required <C-c> if selected to yank it on nvim)
--]]
