if (vim.g.plugs["telescope.nvim"] ~= nil) then
	local map = {
		i = {
			['<Esc>'] = "close",						--	totally avoid normal mode :3
			['<C-c>'] = "close",						--	totally avoid normal mode :3
			['<leader>q']= "close",						--	totally avoid normal mode :3
			['<M-v>'] = "select_vertical",
			['<M-s>'] = "select_horizontal",
			['<M-t>'] = "select_tab",
			['<C-v>'] = "select_vertical",
			['<C-s>'] = "select_horizontal",
			['<C-t>'] = "select_tab",
			['<C-k>'] = "preview_scrolling_up",
			['<C-j>'] = "preview_scrolling_down",
		}
	}

	--	use this string as vimregex
	local ignore_patterns = {
				'node_modules',
				'obj',
				'bin',
				'%.git',
				'%.vs',
				'tags',
				'%.vim',
			}

	require('telescope').setup {
		defaults = {
			path_display = { "truncate" },
			mappings = map,
			sorting_strategy = 'ascending'
		},
		pickers = {
			find_files = { file_ignore_patterns = ignore_patterns },
			git_files = { file_ignore_patterns = ignore_patterns },
			live_grep = { file_ignore_patterns = ignore_patterns },
		}
	}
end
