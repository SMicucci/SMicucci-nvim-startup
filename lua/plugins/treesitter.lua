return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/playground" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "xml", "json", "sql", "c_sharp" },
				auto_install = true,
				sync_install = false,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024
						local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stat and stat.size > max_filesize then
							return true
						end
					end,
				},
				indent = { enable = true },
				additional_vim_regex_highlighting = false,
				playground = {
					enable = true,
					updatetime = 25,
					persistent_queries = false,
				},
			})
		end,
	},
}
