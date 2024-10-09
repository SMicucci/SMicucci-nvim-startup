--	####################
--		User Command
--	####################
vim.api.nvim_create_user_command('Tags','!ctags -R',{})

--	###################
--		AutoCommand
--	###################

--	#	set tabs
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		--	readable test function
		local check = function(fileTable)
			--	check input
			if (type(fileTable) ~= 'table') then
				return false
			end
			--	typefile
			local type = vim.filetype.match({ buf = 0 })
			--	foreach on input
			local res = table.foreach(fileTable,function(i)
				--	check current type wt element of the table
				if (type == fileTable[i]) then
					return 0	-- not nil return break foreach
				end
			end)
			--	return if foreach return is not null (so there is a match)
			return res ~= nil
		end

		--	default value
		local tablen = 4

		if (check({'cs','cshtml','dockerfile','html','java','javascript','json','lua','python','ruby','vim','xml','yaml'})) then
			tablen = 2
		end

		if (check({'asm','bash','c','cmake','cpp','make','markdown','sh','sql','tex'})) then
			tablen = 8
		end
		
		vim.o.tabstop = tablen
		vim.o.shiftwidth = tablen
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
