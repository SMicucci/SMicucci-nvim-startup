local M = {}
M.au = vim.api.nvim_create_autocmd
M.aug = vim.api.nvim_create_augroup
M.cmd = vim.api.nvim_create_user_command

-- autogroups
local terminal = M.aug("terminal", { clear = true })
local utils = M.aug("utils", { clear = true })
local files = M.aug("files", { clear = true })

--Terminal congifuration (autocmd)
M.au("termopen", {
	group = terminal,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		-- move like native "man"

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
	end,
	desc = "configure options for terminal",
})

-- Highlight yanked text utils (autocmd)
M.au("TextYankPost", {
	group = utils,
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

--FoldToggle (command)
M.cmd("FoldToggle", function()
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.fn.foldlevel(".") > 0 then
		---@diagnostic disable-next-line: param-type-mismatch
		if vim.fn.foldclosed(".") ~= -1 then
			vim.cmd("normal! zo")
		else
			pcall(vim.cmd("normal! zc"))
			---@diagnostic disable-next-line: param-type-mismatch
			if vim.fn.foldclosed(".") == vim.fn.line(".") then
				vim.cmd("normal! j")
			end
		end
	end
end, {
	desc = "toggle fold element",
})

-- M.au()

return M
