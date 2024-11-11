if vim.g.plugs["nvim-dap"] ~= nil then
	local dap = require("dap")
	local dapui = require("dapui")
	local mason = require("mason-nvim-dap")

	--	##	UI config
	dapui.setup()
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	--	##	setup symbol and colors
	vim.fn.sign_define('DapBreakpoint', { text='', texthl='DiffDelete', linehl='Visual', numhl='DiffDelete'})
	vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='IncSearch', linehl='Visual', numhl='IncSearch'})
	vim.fn.sign_define('DapStopped', { text='', texthl='DiffAdd', linehl='TabLineSel', numhl='DiffAdd'})

	--	####################
	--		language adapter
	--	####################

	local mason_path = vim.fn.stdpath("data") .. '/mason/packages/'

	--	##	Bash
	dap.adapters.bashdb = {
		type = 'executable';
		command = mason_path .. 'bash-debug-adapter/bash-debug-adapter';
		name = 'bashdb';
	}
	dap.configurations.sh = {
		{
			type = 'bashdb';
			request = 'launch';
			name = "Launch file";
			showDebugOutput = true;
			pathBashdb = mason_path .. 'bash-debug-adapter/extension/bashdb_dir/bashdb';
			pathBashdbLib = mason_path .. 'bash-debug-adapter/extension/bashdb_dir';
			trace = true;
			file = "${file}";
			program = "${file}";
			cwd = '${workspaceFolder}';
			pathCat = "cat";
			pathBash = "/bin/bash";
			pathMkfifo = "mkfifo";
			pathPkill = "pkill";
			args = {};
			env = {};
			terminalKind = "integrated";
		}
	}


	--	##	C/C++/Rust/Zig
	dap.adapters.codelldb = {
		type = 'server',
		port = "${port}",
		executable = {
			command = mason_path .. 'codelldb/extension/adapter/codelldb',
			args = {"--port", "${port}"},
			--detached = false,	-- On windows you may have to uncomment this
		}
	}
	dap.configurations.c = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}
	dap.configurations.cpp = dap.configurations.c
	dap.configurations.rust = dap.configurations.c
	dap.configurations.zig = dap.configurations.c

	--	##	C#, F#
	dap.adapters.coreclr = {
		type = 'executable',
		command = mason_path .. 'netcoredbg/netcoredbg',
		args = {'--interpreter=vscode'}
	}
	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
			end,
		},
	}

	--	##	Go
	dap.adapters.delve = function(callback, config)
		if config.mode == 'remote' and config.request == 'attach' then
			callback({
				type = 'server',
				host = config.host or '127.0.0.1',
				port = config.port or '38697'
			})
		else
			callback({
				type = 'server',
				port = '${port}',
				executable = {
					command = 'dlv',
					args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
					detached = vim.fn.has("win32") == 0,
				}
			})
		end
	end
	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "delve",
			name = "Debug",
			request = "launch",
			program = "${file}"
		},
		{
			type = "delve",
			name = "Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}"
		},
		-- works with go.mod packages and sub packages 
		{
			type = "delve",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		} 
	}


	--	##	javascript
	dap.adapters.node2 = {
		type = 'executable',
		command = 'node',
		args = {mason_path .. 'node-debug2-adapter/out/src/nodeDebug.js'},
	}
	dap.configurations.javascript = {
		{
			name = 'Launch',
			type = 'node2',
			request = 'launch',
			program = '${file}',
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = 'inspector',
			console = 'integratedTerminal',
		}
	}

end
