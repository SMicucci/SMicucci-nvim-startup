--	###############
--		MAPPING
--	###############

--	##	general
vim.keymap.set('i','<Leader>q','<ESC>')
vim.keymap.set('i','<M-Q>',vim.cmd.Esc)
vim.keymap.set('n','<leader>d','<cmd>Ex<CR>', {silent=true})
vim.keymap.set('n', '<leader>*', '<cmd>let @/ = ""<CR>', {silent= true})
vim.keymap.set('n','<M-v>','<C-v>')		-- thank you windows :3
vim.keymap.set('n','<C-h>',function() vim.lsp.buf.code_action() end)
vim.keymap.set('n','<M-c>n','<cmd>cnext<Enter> zz', {silent= true})		-- thank you windows :3
vim.keymap.set('n','<M-c>p','<cmd>cprev<Enter> zz', {silent= true})		-- thank you windows :3
vim.keymap.set('n','n','nzz')
vim.keymap.set('n','N','Nzz')
vim.keymap.set('n','<Leader>q','<cmd>q<CR>', {silent=true})
vim.keymap.set('n','<Leader>w','<cmd>w<CR>', {silent=true})
vim.keymap.set('n','<Leader>s','<cmd>so%<CR>', {silent=true})

--	##	connect clipboard
if (vim.fn.has("unix") == 1) then
	vim.g.clipboard = {
		name = 'wl-clipboard',
		copy = {
			['+'] = 'wl-copy',
			['*'] = 'wl-copy',
		},
		paste = {
			['+'] = 'wl-paste',
			['*'] = 'wl-paste',
		},
		cache_enabled = 0,
	}
end
if (vim.fn.has("wsl") == 1) then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

--	##	harpoon? ~nope~ _maybe?_
if (vim.g.plugs["harpoon"] == nil) then
	--	##	tabs managment
	vim.keymap.set('n','tl',function() vim.cmd('tabnext') end)
	vim.keymap.set('n','th',function() vim.cmd('tabprev') end)
	vim.keymap.set('n','<C-k>',function() vim.cmd('tabnext') end)
	vim.keymap.set('n','<C-j>',function() vim.cmd('tabprev') end)
	vim.keymap.set('n','tk',function() vim.cmd('tabnext') end)
	vim.keymap.set('n','tj',function() vim.cmd('tabprev') end)
	vim.keymap.set('n','tn',function() vim.cmd('tabnew') end)
	vim.keymap.set('n','tq',function() vim.cmd('tabclose') end)
	vim.keymap.set('n','<Leader>tl',function() vim.cmd('tabmove +1') end)
	vim.keymap.set('n','<Leader>th',function() vim.cmd('tabmove -1') end)
	vim.keymap.set('n','<M-0>',function() vim.cmd('tablast') end)
	for i = 1, 9 do
		vim.keymap.set('n','<M-' .. i ..'>',function() vim.cmd('tabnext ' .. i) end)
	end
	--	##	buffers managment
	if (vim.g.plugs["telescope.nvim"] ~= nil) then
		vim.keymap.set('n', '<leader>bb','<cmd>buffers<CR>')
	end
	vim.keymap.set('n', '<leader>bn','<cmd>bnext<CR>', {silent= true})
	vim.keymap.set('n', '<leader>bp','<cmd>bprev<CR>', {silent= true})
	vim.keymap.set('n', '<leader>bd','<cmd>split<CR><cmd>bn<CR><C-W><C-W><cmd>bd<CR>', {silent= true})	--	split, bn, switch window, delete prev buffer
end

--	##	transparent.nvim
if (vim.g.plugs["transparent.nvim"] ~= nil) then
	vim.keymap.set('n','<Leader>tt','<cmd>TransparentToggle<CR>', {silent= true})
end

--	##	alpha-nvim
if (vim.g.plugs["alpha-nvim"] ~= nil) then
	vim.keymap.set('n','<Leader>a','<cmd>Alpha<CR>', {silent= true})
end

--	##	nerdtree		## removed
if (vim.g.plugs["nerdtree"] ~= nil) then
	vim.keymap.set('n','<C-n>','<cmd>NERDTree<CR>', {silent= true})
	vim.keymap.set('n','<C-h>','<cmd>NERDTreeToggle<CR>', {silent= true})
end

--	##	telescope
if (vim.g.plugs["telescope.nvim"] ~= nil) then
	local builtin = require('telescope.builtin')
	local actions = require('telescope.actions')
	vim.keymap.set('n','<Leader>ff',builtin.find_files, {})
	vim.keymap.set('n','<Leader>bb',builtin.buffers, {})
	--vim.keymap.set('n','<Leader>fg',builtin.git_files, {})
	vim.keymap.set('n','<Leader>fd',builtin.lsp_references, {})
	vim.keymap.set('n','<Leader>fr',builtin.live_grep, {})
	vim.keymap.set('n','<Leader>fh',builtin.lsp_definitions, {})
	--[[
	vim.keymap.set('i','<M-t>', function() actions.select_tab() end)
	vim.keymap.set('i','<M-v>', function() actions.select_vertical() end)
	vim.keymap.set('i','<M-s>', function() actions.select_horizontal() end)
	--]]
end

if ( vim.g.plugs["auto-session"] ~= nil ) then
	vim.keymap.set('n','<Leader>fs','<cmd>SessionSearch<CR>', { silent= true })
	vim.keymap.set('n','<Leader>ss','<cmd>SessionSave<CR>', { silent= true })
end

--	##	vim fugitive
if (vim.g.plugs["vim-fugitive"] ~= nil) then
	vim.keymap.set('n','<Leader>gf','<cmd>Git<CR><C-W>o', {silent= true})
end

--	##	gitsigns
if (vim.g.plugs["gitsigns.nvim"] ~= nil) then
	local gitsigns = require('gitsigns')
	vim.keymap.set('n','<Leader>gb',function()
		gitsigns.toggle_current_line_blame()
		gitsigns.toggle_deleted()
		gitsigns.toggle_linehl()
	end)
	vim.keymap.set('n','<Leader>gd',function()
		gitsigns.diffthis(nil, {vertical = true})
	end)
end

--	##	chatGPT integration
if (vim.g.plugs["chatgpt.nvim"] ~= nil) then
	vim.keymap.set('n','<Leader>cc','<cmd>ChatGPT<CR><Esc>', {silent=true})		-- gpt chat
	vim.keymap.set('v','<Leader>c','<cmd>ChatGPTEditWithIstruction<CR>', {silent=true})		-- gpt with prompt
	vim.keymap.set('n','<Leader>cr','<cmd>ChatGPTRun', {silent=true})		-- gpt precise action
end
