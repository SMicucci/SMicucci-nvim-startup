return {
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install("go")
		end,
		config = function()
			local db = require("dbee")
			local k = require("config.keymap")

			db.setup()

			k.nmap("gq", function()
				db.toggle()
			end, "toggle dbee UI")
		end,
	},
}
