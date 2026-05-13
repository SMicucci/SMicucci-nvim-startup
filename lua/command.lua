local set = vim.opt
local auto_cmd = vim.api.nvim_create_autocmd
local user_cmd = vim.api.nvim_create_user_command

local commands = vim.api.nvim_create_augroup("commands", { clear = true })

---
---@param opts { expandtab: boolean, width: number }
---@return function
local function indent(opts)
	return function(ev)
		local b = vim.bo[ev.buf]
		b.expandtab = opts.expandtab
		b.shiftwidth = opts.width
		b.tabstop = opts.width
		b.softtabstop = opts.expandtab and opts.width or 0
	end
end

auto_cmd("FileType", {
	pattern = {
		"javascript",
		"typescript",
		"html",
		"json",
		"lua",
		"xml",
		"ejs",
		"razor",
		"gohtml",
		"templ",
		"yaml",
		"toml",
	},
	group = commands,
	callback = indent({ width = 2, expandtab = true }),
	desc = "2 space indent",
})

auto_cmd("FileType", {
	pattern = { "c" },
	group = commands,
	callback = indent({ width = 8, expandtab = false }),
	desc = "8 space indent",
})

auto_cmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*",
	group = commands,
	callback = function()
		---@diagnostic disable-next-line: undefined-field
		if set.shiftwidth:get() == 2 then
			set.listchars = "tab: ,multispace: ,extends:,precedes:,nbsp:"
		---@diagnostic disable-next-line: undefined-field
		elseif set.shiftwidth:get() == 4 then
			set.listchars = "tab: ,multispace:   ,extends:,precedes:,nbsp:"
		---@diagnostic disable-next-line: undefined-field
		elseif set.shiftwidth:get() == 8 then
			set.listchars = "tab: ,multispace:       ,extends:,precedes:,nbsp:"
		end
	end,
	desc = "list settings autocmd",
})

auto_cmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.h" },
	group = commands,
	callback = function()
		vim.bo.filetype = "c"
	end,
	desc = "set header c lang, not cpp",
})

auto_cmd("TextYankPost", {
	pattern = "*",
	group = commands,
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
	desc = "color yanked section",
})

user_cmd("FoldToggle", function()
	if vim.fn.foldlevel(".") > 0 then
		if vim.fn.foldclosed(".") ~= -1 then
			vim.cmd("normal! zo")
		else
			pcall(vim.cmd("normal! zc"))
			if vim.fn.foldclosed(".") == vim.fn.line(".") then
				vim.cmd("normal! j")
			end
		end
	end
end, {
	desc = "toggle fold element",
})
