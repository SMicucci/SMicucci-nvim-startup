local csharp_group = vim.api.nvim_create_augroup("c_sharp_plugs", { clear = true })

local initialized = false

-- function to setup roslyn and easy-dotnet (dap included)
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

-- initialize if filetype is correct
vim.api.nvim_create_autocmd("FileType", {
	group = csharp_group,
	once = true,
	pattern = { "cs", "vb", "razor", "cshtml" },
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
      local config = vim.deepcopy(vim.lsp.config["roslyn_ls"])
      config.root_dir = vim.fs.dirname(sln[1])
      if config ~= nil then
        vim.lsp.start(config)
      end
		end
	end,
})

-- intercept virtual buffer
vim.api.nvim_create_autocmd("BufAdd", {
	group = csharp_group,
	pattern = "*__virtual.html",
	callback = function(args)
		local bufnr = args.buf
    local bo = vim.bo[bufnr]
		vim.notify("virtual buffer '" .. args.file .. "' detached", vim.log.levels.INFO)
		bo.buflisted = false
		bo.buftype = "nofile"
		bo.swapfile = false
		bo.modified = false
		vim.b[bufnr].no_lsp = true
		vim.schedule(function()
			for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
				vim.lsp.buf_detach_client(bufnr, client.id)
			end
		end)
	end,
})
vim.api.nvim_create_autocmd({ "BufModifiedSet", "TextChanged" }, {
	group = csharp_group,
	pattern = "*__virtual.html",
	callback = function(args)
		if vim.bo[args.buf].modified then
      vim.bo[args.buf].modified = false
    end
	end,
})
