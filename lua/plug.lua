--	############
--		PLUG
--	############

local Plug = vim.fn['plug#']
--	plugin routine
vim.call('plug#begin')

--	mason-lspconfig.nvim
	Plug('williamboman/mason.nvim')
	Plug('neovim/nvim-lspconfig')
	Plug('williamboman/mason.lspconfig.nvim')

--	DAP
	Plug('mfussenegger/nvim-dap')
	Plug('nvim-neotest/nvim-nio')
	Plug('rcarriga/nvim-dap-ui')
	Plug('jay-babu/mason-nvim-dap.nvim')

--	nvim-cmp
	Plug('hrsh7th/nvim-cmp')
	Plug('hrsh7th/cmp-nvim-lsp')
	Plug('hrsh7th/cmp-buffer')
	Plug('hrsh7th/cmp-path')
	Plug('hrsh7th/cmp-cmdline')
	Plug('ray-x/cmp-treesitter')
	Plug('jezda1337/nvim-html-css')

--	autopairs
	Plug('windwp/nvim-autopairs')

--	vs snip for cmp (wip)
	Plug('hrsh7th/cmp-vsnip')
	Plug('hrsh7th/vim-vsnip')
	Plug('hrsh7th/vim-vsnip-integ')
	Plug('rafamadriz/friendly-snippets')

--	telescope plugin and dependencies
	Plug('nvim-lua/plenary.nvim')
	Plug('nvim-treesitter/nvim-treesitter')
	Plug('nvim-treesitter/playground')
	Plug('nvim-tree/nvim-web-devicons')
	Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x'})

--	session manager, telescope integration
	Plug('rmagatti/auto-session')

--	git implementation
	Plug('lewis6991/gitsigns.nvim')
	Plug('tpope/vim-fugitive')
	Plug('rafamadriz/neon', { ['as'] = 'neon' })

--	colorschemes collection
	Plug('rafi/awesome-vim-colorschemes')

--	initial screen
	Plug('goolord/alpha-nvim')

--	transparent
	Plug('xiyaowong/transparent.nvim')

--	nerdtree, mess around with default Explorer, could be intresting though
--	Plug('preservim/nerdtree')

--	trying to fix C# lsp		# was required just to build in linux the project lmao
	Plug('oranget/vim-csharp')
	Plug('Decodetalkers/csharpls-extended-lsp.nvim')

--	copilot, if you use github copilot uncomment
--	Plug('zbirenbaum/copilot.lua')
--	Plug('zbirenbaum/copilot-cmp')

--	chatgpt plugins and dependencies, alternative to copilot for now
	Plug('muniftanjim/nui.nvim')
	Plug('folke/trouble.nvim')
	Plug('jackmort/chatgpt.nvim')

vim.call('plug#end')

