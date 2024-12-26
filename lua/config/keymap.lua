-- vim.g.mapleader = '`' --us-layout settings

-- functions table
local M = {}
M.nmap = function(keys, command, desc, sil)
  if sil == nil then sil = true end
  if vim.fn.maparg(keys,'n') ~= "" then
    vim.keymap.del('n', keys)
  end
  vim.keymap.set('n', keys, command, { desc = desc, silent = sil })
end
M.vmap = function(keys, command, desc, sil)
  if sil == nil then sil = true end
  if vim.fn.maparg(keys,'v') ~= "" then
    vim.keymap.del('v', keys)
  end
  vim.keymap.set('v', keys, command, { desc = desc, silent = true })
end
M.imap = function(keys, command, desc, sil)
  if sil == nil then sil = true end
  if vim.fn.maparg(keys,'i') ~= "" then
    vim.keymap.del('i', keys)
  end
  vim.keymap.set('i', keys, command, { desc = desc, silent = true })
end

-- default behaviour
M.nmap('<leader>q','<cmd>q<CR>', '[q]uit')
M.nmap('<leader>s','<cmd>w<CR>', '[s]ave')
M.nmap('<leader>e','<cmd>Ex<CR>', '[e]xplore current directory')
M.nmap('<leader>x','<cmd>so %<CR>', 'e[x]ecute current buffer')
M.nmap('<leader>h',':vertical botright help ', 'trigger [h]elp', false)
M.nmap('n','nz<CR>3<C-y>$', 'title next match')
M.nmap('N','Nz<CR>3<C-y>_', 'title prev match')
M.nmap('#','z<CR>3<C-y>', 'select and title it')
M.nmap('<leader>*','<cmd>let @/=""<CR>', 'Reset search register')

-- buffer mapping
M.nmap('<leader>bb','<cmd>buffers<CR>','[b]uffers list')
M.nmap('<leader>bn','<cmd>bn<CR>','[b]uffer [n]ext')
M.nmap('<leader>bp','<cmd>bp<CR>','[b]uffer [p]revious')
-- this is a bit sofisticated (split, prev buf, next win, del buf)
M.nmap('<leader>bd','<C-W>s<cmd>bp<CR><C-W>w<cmd>bd<CR>','[b]uffer [d]elete')

-- window mapping
M.nmap('<leader>w','<C-W>', 'shortcut to [w]indow managment')
M.nmap('<leader>we','<C-W>=', '[w]indow [e]qualize')
M.nmap('<leader>wt','<C-W>T', '[w]indow rotation')

-- tabs mapping
M.nmap('<leader>tl','<cmd>tabn<CR>', 'remap \'gt\'')
M.nmap('<leader>th','<cmd>tabp<CR>', 'remap \'gT\'')
M.nmap('<leader>tn','<cmd>tabnew<CR>', 'create new [t]ab')

-- lsp integrated shortcut
M.nmap('gh',function() vim.lsp.buf.code_action() end,'[g]et [h]elp')
M.nmap('gd',function() vim.lsp.buf.definition() end,'[g]oto [d]efinition')
M.nmap('gD',function() vim.lsp.buf.declaration() end,'[g]oto [D]eclaration')
M.nmap('gR',function() vim.lsp.buf.references() end,'[g]oto [R]eference')

-- export functions
return M
