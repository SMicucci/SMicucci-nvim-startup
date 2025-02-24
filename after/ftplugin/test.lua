local k = require('config.keymap')

print('test required')

k.nmap('<leader>aaa','<cmd>echo cross-keymap work<CR>','test')
