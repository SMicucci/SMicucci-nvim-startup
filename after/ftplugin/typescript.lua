local k = require('config.keymap')
local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2

-- quickfix setting
set.makeprg = "./node_modules/.bin/tsc --noEmit"
-- comma separeted pattern to convert string to qf info
set.errorformat =  { "%-A" }
set.errorformat:prepend { "%f(%l\\,%c): error TS%n: %m" }
set.errorformat:prepend { "%f(%l\\,%c): warning TS%n: %m" }
