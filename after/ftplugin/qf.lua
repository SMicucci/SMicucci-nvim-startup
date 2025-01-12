-- setting of [Q]uick[F]ix list
vim.opt.wrap = false

-- local set = vim.opt_local
local k = require('config.keymap')

k.nmap('<leader>q','<cmd>cclose<CR>','[Q]uit quickfix list', { buffer = 0 })
k.nmap('<leader>h','<cmd>hide<CR>','[H]ide quickfix list', { buffer = 0 })
-- k.nmap('n','<cmd>cnext<CR><C-w>j','goto [N]ext element in quickfix list', { buffer = 0 })
-- k.nmap('N','<cmd>cprev<CR><C-w>j','goto [P]rev element in quickfix list', { buffer = 0 })
k.nmap('n','jzz','center cursor in quickfix list', { buffer = 0 })
k.nmap('N','kzz','center cursor in quickfix list', { buffer = 0 })
-- k.nmap('j','jzz','center cursor in quickfix list', { buffer = 0 })
-- k.nmap('k','kzz','center cursor in quickfix list', { buffer = 0 })
-- k.nmap('<CR>','<CR>z<CR>2<C-y><C-w>j','title selection of quickfix list', { buffer = 0 })
