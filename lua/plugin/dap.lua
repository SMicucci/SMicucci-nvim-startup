local k = vim.keymap
local initialized = false

local function setup_dap()
	if initialized then
		return
	end
	initialized = true

	local dap = require("dap")
	local ui = require("dapui")
	require("nvim-dap-virtual-text").setup({})

	---@diagnostic disable-next-line: missing-fields
	ui.setup({
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 1 },
				},
				position = "bottom",
				size = 12,
			},
			{
				elements = {
					{ id = "breakpoints", size = 0.15 },
					{ id = "stacks", size = 0.20 },
					{ id = "repl", size = 0.75 },
				},
				position = "right",
				size = 60,
			},
		},
		---@diagnostic disable-next-line: missing-fields
		floating = {
			border = "rounded",
		},
	})
	dap.listeners.before.attach.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		ui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		ui.close()
	end

	dap.set_log_level("TRACE")

	-- join mason path
	local function mason_bin(bin_name)
		return vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "mason", "bin", bin_name))
	end

	-- C/C++/Rust/Zig
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
	}
	dap.configurations.c = {
		{
			name = "Launch",
			type = "gdb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtBeginningOfMainSubprogram = false,
			args = function()
				local input = vim.fn.input("Program arguments: ")
				return vim.split(input, " ", { trimepty = true })
			end,
		},
		{
			name = "Select and attach to process",
			type = "gdb",
			request = "attach",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			pid = function()
				local name = vim.fn.input("Executable name (filter): ")
				return require("dap.utils").pick_process({ filter = name })
			end,
			cwd = "${workspaceFolder}",
		},
		{
			name = "Attach to gdbserver :1234",
			type = "gdb",
			request = "attach",
			target = "localhost:1234",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
	}
	dap.configurations.cpp = dap.configurations.c
	dap.configurations.rust = dap.configurations.c
	dap.configurations.zig = dap.configurations.c

	-- C#
	dap.adapters.coreclr = {
		type = "executable",
		command = vim.g.is_win and vim.fs.normalize(
			vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "netcoredbg", "netcoredbg", "netcoredbg.exe")
		) or vim.fs.normalize(
			vim.fs.joinpath(
				vim.fn.stdpath("data"),
				"mason",
				"packages",
				"netcoredbg",
				"libexec",
				"netcoredbg",
				"netcoredbg"
			)
		),
		args = { "--interpreter=vscode" },
	}
	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "Launch - easy-dotnet",
			request = "launch",
			env = function()
				local spec = require("easy-dotnet").get_debug_dll()
				require("easy-dotnet").build_default_quickfix()
				return spec.environment_variables
			end,
			program = function()
				return require("easy-dotnet").get_debug_dll().dll
			end,
			cwd = function()
				return require("easy-dotnet").get_debug_dll().relative_dll.path
			end,
		},
	}

	-- Typescript
	dap.adapters.node = {
		type = "executable",
		command = "bash",
		args = { mason_bin("node-debug2-adapter") },
	}
	dap.configurations.typescript = {
		{
			name = "Launch node",
			type = "node",
			request = "launch",
			runtimeArgs = { "--inspect", "-r", "ts-node/register" },
			runtimeExecutable = "node",
			args = { "${file}" },
			--port = 9229,
			cwd = "${workspaceFolder}",
			skipFiles = { "node_modules/**" },
			console = "integratedTerminal",
		},
	}

	-- Python
	local sep = package.config:sub(1, 1)
	local subdir = vim.g.is_win and "Scripts" or "bin"
	local exe = vim.g.is_win and "python.exe" or "python"
	local function try(p)
		return p and vim.fn.executable(p) == 1 and p or nil
	end
	local mason = table.concat({
		vim.fn.stdpath("data"),
		"mason",
		"packages",
		"debugpy",
		"venv",
		subdir,
		exe,
	}, sep)
	local venv = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. sep .. subdir .. sep .. exe) or nil
	local python_path = try(mason) or try(venv) or (vim.fn.exepath("python3") ~= "" and "python3" or "python")
	require("dap-python").setup(python_path)

	-- Golang
	require("dap-go").setup()
end

-- dap commands
k.set("n", "<leader>dc", function()
	setup_dap()
	require("dap").continue()
end, { desc = "[d]ap continue" })
k.set("n", "<space>c", function()
	setup_dap()
	require("dap").continue()
end, { desc = "[d]ap continue" })
k.set("n", "<leader>dn", function()
	require("dap").step_over()
end, { desc = "[d]ap step next" })
k.set("n", "<space>n", function()
	require("dap").step_over()
end, { desc = "[d]ap step next" })
k.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "[d]ap step into" })
k.set("n", "<space>i", function()
	require("dap").step_into()
end, { desc = "[d]ap step into" })
k.set("n", "<leader>do", function()
	require("dap").step_out()
end, { desc = "[d]ap step over" })
k.set("n", "<space>o", function()
	require("dap").step_out()
end, { desc = "[d]ap step over" })

-- breakpoints
k.set("n", "<leader>db", function()
	setup_dap()
	require("dap").toggle_breakpoint()
end, { desc = "[d]ap toggle breakpoint" })
k.set("n", "<space>b", function()
	setup_dap()
	require("dap").toggle_breakpoint()
end, { desc = "[d]ap toggle breakpoint" })
k.set("n", "<leader>dB", function()
	require("dap").set_breakpoint()
end, { desc = "[d]ap toggle breakpoint" })
k.set("n", "<space>B", function()
	require("dap").set_breakpoint()
end, { desc = "[d]ap toggle breakpoint" })

-- setup symbols
local signs = {
	DapBreakpoint = { text = "", texthl = "DiffDelete", linehl = "Visual", numhl = "DiffDelete" },
	DapBreakpointCondition = { text = "", texthl = "IncSearch", linehl = "Visual", numhl = "IncSearch" },
	DapStopped = { text = "", texthl = "DiffText", linehl = "DiffChange", numhl = "DiffText" },
}
for name, opts in pairs(signs) do
	vim.fn.sign_define(name, opts)
end
