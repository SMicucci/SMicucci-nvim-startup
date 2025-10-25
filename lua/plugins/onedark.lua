-- lua/plugins/onedark.lua
return {
	{
		"rakr/vim-one",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme one]])
			vim.o.background = "dark"
		end,
	},
	{
		"projekt0n/github-nvim-theme",
	},
}
