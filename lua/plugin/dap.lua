if vim.g.plugs["nvim-dap"] ~= nil and vim.g.plugs["mason.nvim"] ~= nil and vim.g.plugs["mason-nvim-dap.nvim"] ~= nil then
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

	print("entered")
	mason.setup({
		ensure_installed = {
			--	#	bash debugger
			--'bash',
			--	#	C# debugger
			--'coreclr',
			--	#	C, C++, rust, zig debugger
			'codelldb',
			--	#	dart debugger
			--'dart',
			--	#	GO debugger
			--'delve',
			--	#	javascript debugger
			'js',
			--	#	python debugger
			--'python',
		},
		automatic_installation = {
			function(config)
				mason.default_config(config)
			end
		}
	})

end
