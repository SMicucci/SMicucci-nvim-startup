local w = require("which-key")
local k = vim.keymap
w.setup({
	preset = "modern",
	delay = 500,
})
k.set("n", "<leader>?", function()
	w.show({ global = false })
end, { desc = "which-key toggle" })
