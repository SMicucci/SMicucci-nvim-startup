local csharp_group = vim.api.nvim_create_augroup("c_sharp_plugs", { clear = true })

local initialized = false

-- roslyn.nvim enables the `roslyn` client itself and owns the razor virtual
-- buffers. Plugin options only, server settings live in plugin/lsp.lua.
require("roslyn").setup()

-- function to setup easy-dotnet (dap included)
local function setup_csharp()
	if initialized then
		return
	end
	initialized = true

	local function get_debugger_path()
		local path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "netcoredbg")
		if vim.g.is_win then
			path = path .. ".cmd"
		end
		return path
	end

	require("easy-dotnet").setup({
		lsp = {
			enabled = false,
			roslynator_enabled = false,
		},
		debugger = {
			enabled = true,
			bin_path = get_debugger_path(),
		},
		diagnostics = {
			default_severity = "warning",
			setqflist = true,
			auto_open = true,
		},
	})
end

-- initialize if filetype is correct (*.cshtml maps to the `razor` filetype)
vim.api.nvim_create_autocmd("FileType", {
	group = csharp_group,
	once = true,
	pattern = { "cs", "vb", "razor" },
	callback = function()
		setup_csharp()
	end,
})

-- initialize if solution is present here or in upped directory
vim.api.nvim_create_autocmd("BufEnter", {
	group = csharp_group,
	once = true,
	callback = function()
		local sln = vim.fs.find(function(name)
			return name:match("%.sln$")
		end, { upward = true, type = "file" })
		if #sln > 0 then
			setup_csharp()
		end
	end,
})
