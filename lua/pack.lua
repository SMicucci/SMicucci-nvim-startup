require("plugin.build")

vim.pack.add({
	-- libraries
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	-- LSP
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim.git" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	-- completion
	{ src = "https://github.com/l3mon4d3/luasnip" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	-- folke
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	-- git
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- linter
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
	-- C#
	{ src = "https://github.com/seblyng/roslyn.nvim" },
	{ src = "https://github.com/GustavEikaas/easy-dotnet.nvim" },
	-- DAP
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://codeberg.org/mfussenegger/nvim-dap-python" },
	-- claude
	{ src = "https://github.com/coder/claudecode.nvim" },
}, { confirm = true })
