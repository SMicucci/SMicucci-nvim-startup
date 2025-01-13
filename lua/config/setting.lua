local set = vim.opt
local auto = require'config.command'
local setting = auto.aug('settings', { clear = true })

--[[
copied text stay in register '+'
selected text (linux) stay in register '*'
(yes, isn't required <C-c> if selected to yank it on nvim)
--]]

--{{{ # settings by lua
--basis
set.mousehide = true
set.showtabline = 2
set.number = true
set.relativenumber = true
set.syntax = 'on'
set.termguicolors = true

--menu
set.wildmenu = true
set.wildoptions = 'pum'
set.wildmode = 'full'

-- folding
set.foldmethod = 'marker'
set.foldmarker = '{{{,}}}' -- default
set.foldclose = 'all'
set.foldenable = true

-- tabs in vim => #3
set.list = true
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
vim.cmd '%retab!'

--}}}

--{{{ # global variable settings
if vim.fn.executable('rg') then
  local ignore_dir = {
    "bin",
    "build",
    "dist",
    ".git",
    "node_modules",
    "obj",
    "vendor",
    ".vs",
  }
  vim.g.grepprg = { 'rg', '--vimgrep', '--smart-case', '--hidden', }
  for _, dir in ipairs(ignore_dir) do
    if vim.fn.has('win32') then
      table.insert(vim.g.grepprg, string.format('--glob=\'!**\\%s\\*\'', dir))
    else
      table.insert(vim.g.grepprg, string.format('--glob=\'!**/%s/*\'', dir))
    end
  end
  table.insert(vim.g.grepprg, '--')
else
  vim.notify('󰀦 ripgrep not installed (recommended)\n',vim.log.levels.WARN)
  vim.g.grepprg = 'internal'
end
--}}}

--{{{ # list settings
auto.au({'BufEnter', 'BufNewFile'}, {
  pattern = '*',
  group = setting,
  callback = function ()
    ---@diagnostic disable-next-line: undefined-field
    if set.shiftwidth:get() == 2 then
      set.listchars = "tab: ,multispace: ,extends:,precedes:,nbsp:"
      ---@diagnostic disable-next-line: undefined-field
    elseif set.shiftwidth:get() == 4 then
      set.listchars = "tab: ,multispace:   ,extends:,precedes:,nbsp:"
      ---@diagnostic disable-next-line: undefined-field
    elseif set.shiftwidth:get() == 8 then
      set.listchars = "tab: ,multispace:       ,extends:,precedes:,nbsp:"
    end
  end,
  desc = 'list settings autocmd',
})
--}}}

