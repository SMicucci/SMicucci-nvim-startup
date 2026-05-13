local k = vim.keymap
local gs = require("gitsigns")

gs.setup({
	numhl = false,
	signcolumn = false,
	current_line_blame_formatter = "<abbrev_sha> (<author>) <author_time:%d %b %y>",
	current_line_blame_opts = {
		virt_text_pos = "right_align",
		delay = 250,
	},
})

k.set("n", "<leader>gf", "<cmd>Git<cr><c-w>T", { desc = "open fugitive" })
k.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "fugitive split" })
k.set("n", "<leader>gb", function()
	gs.toggle_numhl()
	gs.toggle_current_line_blame()
	gs.preview_hunk_inline()
end, { desc = "git signs blame" })
