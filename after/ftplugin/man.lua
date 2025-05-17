local set = vim.opt_local

local nmap = function(lhs, rhs, description)
	---@type vim.api.keyset.keymap
	local opts = { desc = description, noremap = true, silent = true }
	pcall(vim.api.nvim_buf_del_keymap, 0, "n", lhs)
	vim.api.nvim_buf_set_keymap(0, "n", lhs, rhs, opts)
end

nmap("d", "<C-d>", "man page navigation")
nmap("u", "<C-u>", "man page navigation")
nmap("j", "<C-e>", "man page navigation")
nmap("k", "<C-y>", "man page navigation")
nmap("<C-j>", "j", "man page navigation")
nmap("<C-k>", "k", "man page navigation")
