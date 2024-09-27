local map = { i = {
	['<esc>'] = "close",						--	totally avoid normal mode :3
	['<M-v>'] = "select_vertical",
	['<M-s>'] = "select_horizontal",
	['<M-t>'] = "select_tab",
	['<C-v>'] = "select_vertical",
	['<C-s>'] = "select_horizontal",
	['<C-t>'] = "select_tab",
	['<C-k>'] = "preview_scrolling_up",
	['<C-j>'] = "preview_scrolling_down",
} }

local is_git = {}
local search_files = function ()
	local opts = {}
	local cwd = vim.fn.getcwd()
	if is_git[cwd] == nil then
		vim.fn.system('git rev-parse --is-inside-work-tree')
		is_git[cwd] = vim.v.shell_error == 0
	end
	if is_git[cwd] then
		require('telescope.builtin').git_files(opts)
	else
		require('telescope.builtin').find_files(opts)
	end
end

require('telescope').setup {
	defaults = {
		file_ignore_pattern = {
			'node_modules',
			'obj',
			'bin',
			'.git',
			'.vs',
		}
	},
	pickers = {
		find_files = { mappings = map },
		oldfiles = { mappings = map },
		git_files = { mappings = map },
		live_grep = { mappings = map },
		lsp_references= { mappings = map },
		lsp_definitions = { mappings = map },
	}
}
