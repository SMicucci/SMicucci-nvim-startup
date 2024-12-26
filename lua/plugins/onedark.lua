-- lua/plugins/onedark.lua
return {
	{
		"joshdick/onedark.vim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end,
	},
}
