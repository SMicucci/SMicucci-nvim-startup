--	################
--		SETTINGS
--	################

vim.o.mousehide = true
vim.o.expandtab = false
vim.o.number = true
vim.o.relativenumber = false
vim.o.showtabline = 2
vim.o.syntax = 'on'
vim.o.termguicolors = true
vim.o.wildmenu = true
vim.o.wildoptions = 'pum'
vim.o.wildmode = 'full'

--	###################
--		INDENTATION
--	###################

-- tabstop => #5 always <Tab>
vim.o.expandtab = false
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'html',
	callback = function()
		vim.o.tabstop = 2
		vim.o.shiftwidth = 2
	end,
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'c',
	callback = function()
		vim.o.tabstop = 8
		vim.o.shiftwidth = 8
	end,
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	callback = function()
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
	end,
})

--	###################
--		AUTOCOMMAND
--	###################
vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
	pattern = {'*.cshtml'},
	command = "set filetype=cshtml.html"
})

vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
	pattern = {'*.ejs'},
	command = "set filetype=html"
})

--	##############
--		COLORS
--	##############
--	vim.cmd.colorscheme('sonokai')
--	vim.cmd.colorscheme('atom')
	vim.cmd.colorscheme('one')
--	vim.cmd.colorscheme('onedark')
--	vim.cmd.colorscheme('challenger_deep')
--		light colorscheme o.O
--	vim.cmd.colorscheme('carbonized-light')
--		transp combo o.O
--	vim.cmd.colorscheme('carbonized-dark')
--	vim.cmd.colorscheme('flattened-dark')
--	vim.cmd.colorscheme('materialbox')
