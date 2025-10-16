return {
	"lewis6991/hover.nvim",
	config = function()
		local k = require("config.keymap")
		local hover = require("hover")
		hover.config({
			providers = {
				"hover.providers.lsp",
				"hover.providers.dap",
				"hover.providers.diagnostic",
				"hover.providers.fold_preview",
				"hover.providers.man",
			},
			mouse_providers = {
				"hover.providers.lsp",
			},
			preview_window = true,
			title = true,
			mouse_delay = 1000,
		})

		k.nmap("K", hover.open, "hover plugin default")
		k.nmap("gK", hover.select, "hover plugin select")
		k.nmap("<C-p>", function()
			hover.switch("previous")
		end, "hover plugin previous")
		k.nmap("<C-n>", function()
			hover.switch("next")
		end, "hover plugin next")
		k.nmap("<MouseMove>", hover.mouse, "hover plugin mouse")
		vim.o.mousemoveevent = true
	end,
}
