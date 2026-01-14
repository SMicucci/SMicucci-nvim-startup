return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	config = function()
		local gs = require("gitsigns")
		local k = require("config.keymap")
		gs.setup({
			numhl = false,
			signcolumn = false,

			current_line_blame_formatter = "<abbrev_sha> (<author>) <author_time:%d %b %y>",
			current_line_blame_opts = {
				virt_text_pos = "right_align",
				delay = 250,
			},
		})
		k.nmap("<leader>gb", function()
			gs.toggle_numhl()
			gs.toggle_current_line_blame()
			gs.preview_hunk_inline()
		end, "git sign blame-mode")
	end,
}
