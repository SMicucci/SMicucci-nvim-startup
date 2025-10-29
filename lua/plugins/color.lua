-- lua/plugins/onedark.lua
return {
	{
		"rakr/vim-one",
		lazy = false,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme github_dark_default]])
			vim.o.background = "dark"
		end,
	},
}
