return {
	"lewis6991/hover.nvim",
	config = function()
		local k = require("config.keymap")
		local hover = require("hover")
		hover.config({
			init = function()
				require("hover.providers.lsp")
				require("hover.providers.dap")
				require("hover.providers.diagnostic")
				require("hover.providers.man")
			end,
		})

		k.nmap("K", hover.open, "hover plugin default")
		k.nmap("gK", hover.select, "hover plugin select")
		k.nmap("<C-p>", function()
			---@diagnostic disable-next-line: missing-parameter
			hover.switch("previous")
		end, "hover plugin previous")
		k.nmap("<C-n>", function()
			---@diagnostic disable-next-line: missing-parameter
			hover.switch("next")
		end, "hover plugin next")
		k.nmap("<MouseMove>", hover.mouse, "hover plugin mouse")
		vim.o.mousemoveevent = true
	end,
}
