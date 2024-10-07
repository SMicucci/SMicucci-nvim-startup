--	####################
--		User Command
--	####################
vim.api.nvim_create_user_command('Tags','!ctags -R',{})

--	###################
--		AutoCommand
--	###################
--	#	set default tabs
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
	end,
})

--	#	set small tabs
vim.api.nvim_create_autocmd('FileType', {
	pattern = {"*.lua", "*.html", "*.htm", "*.py", "*.rb"},
	callback = function()
		vim.o.tabstop = 2
		vim.o.shiftwidth = 2
	end,
})

--	#	set large tabs
vim.api.nvim_create_autocmd('FileType', {
	pattern = {"*.c", "*.h", "*.cpp", "*.hh", "*.css"},
	callback = function()
		vim.o.tabstop = 8
		vim.o.shiftwidth = 8
	end,
})

--	##	expand parentesis and string delimeter
vim.api.nvim_create_autocmd('InsertCharPre',{
	desc = "expand parentesis when writing buffer",
	callback = function ()
		local char = vim.v.char
		local pos = vim.api.nvim_win_get_cursor(0)
		if (char == '"') then
			vim.schedule(function()
				vim.api.nvim_buf_set_text(0, pos[1]-1, pos[2]+1, pos[1]-1, pos[2]+1, {'"'})
				vim.api.nvim_win_set_cursor(0, {pos[1],pos[2]+1})
			end)
		end
		if (char == "'") then
			vim.schedule(function()
				vim.api.nvim_buf_set_text(0, pos[1]-1, pos[2]+1, pos[1]-1, pos[2]+1, {"'"})
				vim.api.nvim_win_set_cursor(0, {pos[1],pos[2]+1})
			end)
		end
		if (char == '(') then
			vim.schedule(function()
				vim.api.nvim_buf_set_text(0, pos[1]-1, pos[2]+1, pos[1]-1, pos[2]+1, {")"})
				vim.api.nvim_win_set_cursor(0, {pos[1],pos[2]+1})
			end)
		end
		if (char == '[') then
			vim.schedule(function()
				vim.api.nvim_buf_set_text(0, pos[1]-1, pos[2]+1, pos[1]-1, pos[2]+1, {"]"})
				vim.api.nvim_win_set_cursor(0, {pos[1],pos[2]+1})
			end)
		end
		if (char == '{') then
			vim.schedule(function()
				vim.api.nvim_buf_set_text(0, pos[1]-1, pos[2]+1, pos[1]-1, pos[2]+1, {" }"})
				vim.api.nvim_win_set_cursor(0, {pos[1],pos[2]+1})
			end)
		end
	end
})

--[[

....
....
....

--]]
--	vim.api.nvim_create_autocmd({''},{pattern = {''}, command = {''}, callback = {''}})
