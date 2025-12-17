return {
	"mfussenegger/nvim-dap-python",
	ft = "python",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local debug = require("dap-python")
		local dap = require("dap")

		debug.setup("python3")
		table.insert(dap.configurations.python, {
			type = "python",
			request = "launch",
			name = "Flask: Launch (justMyCode = false)",
			module = "flask",
			args = { "run", "--no-debugger", "--no-reload" },
			env = {
				FLASK_APP = "run.py",
				FLASK_DEBUG = "1",
			},
			justMyCode = false,
			console = "integratedTerminal",
		})
	end,
}
