-- lua/plugins/onedark.lua
return {
	{
		"rakr/vim-one",
		lazy = false,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github_theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({})
			vim.cmd("colorscheme github_dark")
			-- vim.cmd("colorscheme one")
			vim.o.background = "dark"
		end,
	},
}
