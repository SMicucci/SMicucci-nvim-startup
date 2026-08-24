vim.api.nvim_create_user_command("Cargo", function(opts)
	Snacks.terminal.open("cargo " .. opts.args, {
		win = {
			position = "float",
			width = 0.35,
			height = 0.9,
			border = "rounded",
			col = vim.o.columns - math.floor(vim.o.columns * 0.35) - 2,
		},
	})
end, {
	nargs = "+",
	complete = function()
		return { "build", "run", "test", "check", "clippy", "fmt", "doc", "clean", "update", "add" }
	end,
})
