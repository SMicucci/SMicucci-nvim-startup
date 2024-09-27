--	############
--		PLUG
--	############

local Plug = vim.fn['plug#']
--	plugin routine
vim.call('plug#begin')

--	colorschemes collection
	Plug('rafi/awesome-vim-colorschemes')
--	transparent
	Plug('xiyaowong/transparent.nvim')
--	nerdtree
--	Plug('preservim/nerdtree')
--	telescope
	Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x'})
--	telescope-dependencies
	Plug('nvim-lua/plenary.nvim')
	Plug('nvim-treesitter/nvim-treesitter')
	Plug('nvim-treesitter/playground')
	Plug('nvim-tree/nvim-web-devicons')
--	mason-lspconfig.nvim
	Plug('williamboman/mason.lspconfig.nvim')
	Plug('williamboman/mason.nvim')
	Plug('neovim/nvim-lspconfig')
--	nvim-cmp
	Plug('hrsh7th/nvim-cmp')
	Plug('hrsh7th/cmp-nvim-lsp')
	Plug('hrsh7th/cmp-buffer')
	Plug('hrsh7th/cmp-path')
	Plug('hrsh7th/cmp-cmdline')
	Plug('ray-x/cmp-treesitter')
	Plug('jezda1337/nvim-html-css')
--	vs snip
	Plug('hrsh7th/cmp-vsnip')
	Plug('hrsh7th/vim-vsnip')
	Plug('hrsh7th/vim-vsnip-integ')
	Plug('rafamadriz/friendly-snippets')

--	git implementation i guess
--	Plug('neogitorg/neogit', { ['tag'] = 'v0.0.1'})
	Plug('sindrets/diffview.nvim')
	Plug('tpope/vim-fugitive')
	Plug('rafamadriz/neon', { ['as'] = 'neon' })

--	git diff in file
	Plug('lewis6991/gitsigns.nvim')

--	trying to fix C# lsp		# was required just to build in linux the project lmao
	Plug('oranget/vim-csharp')
	Plug('Decodetalkers/csharpls-extended-lsp.nvim')

vim.call('plug#end')

