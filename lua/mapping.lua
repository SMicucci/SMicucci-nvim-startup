--	###############
--		MAPPING
--	###############

--	##	general
vim.keymap.set('i','<Leader>q','<ESC>')
vim.keymap.set('i','<M-Q>',vim.cmd.Esc)
vim.keymap.set('n','<leader>gd',vim.cmd.Ex)
vim.keymap.set('n','<leader>*',vim.cmd.nohlsearch)
vim.keymap.set('n','<M-v>','<C-v>')		-- thank you windows :3
vim.keymap.set('n','<C-h>',function() vim.lsp.buf.code_action() end)
vim.keymap.set('n','<M-c>n',':cnext<Enter> zz')		-- thank you windows :3
vim.keymap.set('n','<M-c>p',':cprev<Enter> zz')		-- thank you windows :3
vim.keymap.set('n','n','nzz')
vim.keymap.set('n','N','Nzz')

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

--	##	user command
vim.api.nvim_create_user_command('Tags','!ctags -R',{})

--vim.keymap.set('i','{}','{\n.\n}<Esc>Vkk<C-=>jcc')	--	schatchy implementation of a snippet lol

--	##	harpoon? nope
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

--	##	transparent.nvim
if (vim.g.plugs["transparent.nvim"] ~= nil) then
	vim.keymap.set('n','<Leader>tt',':TransparentToggle<CR>')
end

--	##	nerdtree
if (vim.g.plugs["nerdtree"] ~= nil) then
	vim.keymap.set('n','<C-n>',':NERDTree<CR>')
	vim.keymap.set('n','<C-h>',':NERDTreeToggle<CR>')
end

--	##	telescope
if (vim.g.plugs["telescope.nvim"] ~= nil) then
	local builtin = require('telescope.builtin')
	local actions = require('telescope.actions')
	vim.keymap.set('n','<Leader>ff',builtin.find_files, {})
	vim.keymap.set('n','<Leader>fb',builtin.buffers, {})
	vim.keymap.set('n','<Leader>fo',function() builtin.oldfiles({only_cwd = true}) end, {})
	vim.keymap.set('n','<Leader>fg',builtin.git_files, {})
	vim.keymap.set('n','<Leader>fd',builtin.lsp_references, {})
	vim.keymap.set('n','<Leader>fr',builtin.live_grep, {})
	vim.keymap.set('n','<Leader>fh',builtin.lsp_definitions, {})
	--[[
	vim.keymap.set('i','<M-t>', function() actions.select_tab() end)
	vim.keymap.set('i','<M-v>', function() actions.select_vertical() end)
	vim.keymap.set('i','<M-s>', function() actions.select_horizontal() end)
	--]]
end

--	##	gitsigns
if (vim.g.plugs["gitsigns.nvim"] ~= nil) then
	local gitsigns = require('gitsigns')
	vim.keymap.set('n','<Leader>glb',gitsigns.toggle_current_line_blame)
	vim.keymap.set('n','<Leader>gb',gitsigns.toggle_current_line_blame)
	vim.keymap.set('n','<Leader>gd',gitsigns.toggle_deleted)
end


--	##	mason-lspconfig
--		this mapping is located on lua/plugin/lsp-config.lua

--		functions for keymaps
--	#########
--		vim.keymap.set({mode},{trigger-sequence},{output-sequence})
--		vim.keymap.del({mode},{trigger-sequence})
--	#########

--	#############
--		DEBUG
--	#############
--print(vim.inspect(vim.g.plugs))
