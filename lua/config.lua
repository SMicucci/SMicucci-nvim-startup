local set = vim.opt
local loc = vim.opt_local

-- base
set.mousehide = true
set.showtabline = 2
set.number = true
set.relativenumber = true
set.syntax = "on"
set.termguicolors = true
vim.cmd.colorscheme("catppuccin")

-- split
set.splitbelow = true
set.splitright = true

-- menu
set.wildmenu = true
set.wildoptions = "pum"
set.wildmode = "full"

-- folding
set.foldclose = "all"
set.foldlevelstart = 99
set.foldenable = true

-- tabs in vim => #3
set.list = false
set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
vim.cmd("%retab!")

-- global variable settings
vim.g.system = vim.loop.os_uname().sysname
vim.g.is_win = vim.g.system == "Windows_NT"
vim.g.is_linux = vim.g.system == "Linux"
vim.g.is_wsl = vim.g.is_linux and os.getenv("WSL_DISTRO_NAME") ~= nil

if vim.g.is_wsl then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

if vim.fn.executable("rg") then
	local ignore_dir = {
		"bin",
		"build",
		"dist",
		".git",
		"node_modules",
		"obj",
		"vendor",
		".vs",
	}
	local gp = { "rg", "--vimgrep", "--smart-case", "--hidden" }
	for _, dir in ipairs(ignore_dir) do
		if vim.g.is_win then
			table.insert(gp, string.format("--glob=!**\\%s\\*", dir))
		else
			if vim.fn.has("zsh") then
				table.insert(gp, string.format("--glob '!**/%s/*'", dir))
			else
				table.insert(gp, string.format("--glob=!**/%s/*", dir))
			end
		end
	end
	table.insert(gp, "--")
	set.grepprg = table.concat(gp, " ")
else
	vim.notify("󰀦 ripgrep not installed (recommended)\n", vim.log.levels.WARN)
	set.grepprg = "internal"
end

-- # handle internally command with cmd but open terminal with powershell
if vim.g.is_win then
	set.shell = "cmd.exe"
	set.shellcmdflag = "/c"
	set.shellquote = ""
	set.shellxquote = ""
	vim.env.COMSPEC = "C:\\Windows\\System32\\cmd.exe"
	vim.api.nvim_create_autocmd("TermOpen", {
		pattern = "*",
		callback = function()
			loc.shell = "powershell.exe"
			loc.shellcmdflag = "-NoLogo"
		end,
		desc = "windows run powershell",
	})
end

-- razor filetype
vim.filetype.add({
	extension = {
		razor = "razor",
		cshtml = "razor",
	},
})


