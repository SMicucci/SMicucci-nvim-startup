-- vim.g.mapleader = '`' --us-layout settings

-- functions table
local M = {}
M.nmap = function(keys, command, desc, opts)
  opts = opts or {}
  if vim.fn.maparg(keys,'n') ~= "" and not opts.buffer then
    vim.keymap.del('n', keys)
  end
  assert(not opts.desc, 'keymap desc must be assigned on argument')
  opts.desc= desc
  vim.keymap.set('n', keys, command, opts)
end
M.vmap = function(keys, command, desc, opts)
  opts = opts or {}
  if vim.fn.maparg(keys,'v') ~= "" and not opts.buffer then
    vim.keymap.del('v', keys)
  end
  assert(not opts.desc, 'keymap desc must be assigned on argument')
  opts.desc= desc
  vim.keymap.set('v', keys, command, opts)
end
M.imap = function(keys, command, desc, opts)
  opts = opts or {}
  if vim.fn.maparg(keys,'i') ~= "" and not opts.buffer then
    vim.keymap.del('i', keys)
  end
  assert(not opts.desc, 'keymap desc must be assigned on argument')
  opts.desc= desc
  vim.keymap.set('i', keys, command, opts)
end
M.tmap = function(keys, command, desc, opts)
  opts = opts or {}
  if vim.fn.maparg(keys,'t') ~= "" and not opts.buffer then
    vim.keymap.del('t', keys)
  end
  assert(not opts.desc, 'keymap desc must be assigned on argument')
  opts.desc= desc
  vim.keymap.set('t', keys, command, opts)
end

-- default behaviour
M.nmap('<leader>q','<cmd>q<CR>', '[q]uit')
M.nmap('<leader>s','<cmd>w<CR>', '[s]ave')
M.nmap('<leader>e','<cmd>Ex<CR>', '[e]xplore current directory')
M.nmap('<leader>x','<cmd>so %<CR>', 'e[x]ecute current buffer')
M.nmap('<leader>h',':vertical botright help ', 'trigger [h]elp', { silent = false})
M.nmap('n','nzz', 'center next match')
M.nmap('N','Nzz', 'center prev match')
M.nmap('#','z<CR>2<C-y>', 'select and title it')
M.nmap('<leader>*','<cmd>let @/=""<CR>', 'Reset search register')
M.nmap('<leader>\'',function() vim.opt.wrap = not vim.opt.wrap:get() end,'switch wrap setting')

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
M.nmap('gr',function() vim.lsp.buf.references() end,'[g]oto [R]eference')
M.nmap('gR',function() vim.lsp.buf.rename() end,'[g]oto [R]ename')
M.imap('<C-R>',function() vim.lsp.buf.rename() end,'[g]oto [R]ename')

-- terminal mapping
M.tmap('<Esc>','<C-\\><C-n>','exit from terminal')

-- quickfix integrated
M.nmap('<leader>c','<cmd>cwindow 8<CR>','open qflist')
M.nmap('<leader>cn','<cmd>cnext<CR>','qflist next entry')
M.nmap('<leader>cj','<cmd>cnext<CR>','qflist next entry')
M.nmap('<leader>cp','<cmd>cNext<CR>','qflist prev entry')
M.nmap('<leader>ck','<cmd>cNext<CR>','qflist prev entry')
M.nmap('<leader>cm','<cmd>make<CR><cmd>cwindow 8<CR>','open qflist')
-- M.nmap('<leader>c','<cmd>cwindow 8<CR>','open qflist')

-- fold custom integration
M.nmap('<C-o>','<cmd>FoldToggle<CR>','trigger f[O]ldtoggle command')
M.imap('<C-o>','<cmd>FoldToggle<CR>','trigger f[O]ldtoggle command')

-- export functions
return M
