--[[
local corner = 	{ '╭', '╮', '╯', '╰' }
local light =	{ '─', '│', '┌', '┐', '└', '┘', '├', '┤', '┬', '┴', '┼' }
local heavy =	{ '━', '┃', '┏', '┓', '┗', '┛', '┣', '┫', '┳', '┻', '╋' }
local double =	{ '═', '║', '╔', '╗', '╚', '╝', '╠', '╣', '╦', '╩', '╬' }
--]]

if (vim.g.plugs["gitsigns.nvim"] ~= nil) then
	require('gitsigns').setup {
		numhl = true,
		current_line_blame_opts = {
			delay = 100,
			virt_text_pos = 'right_align',
		},
		current_line_blame_formatter = '<abbrev_sha>: <author>, <author_time:%x>',
	}
end
