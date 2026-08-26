local k = vim.keymap

k.set("n", "<leader>q", "<cmd>q<CR>", { desc = "[q]uit" })
k.set("n", "<leader>s", "<cmd>w<CR>", { desc = "[s]ave" })
k.set("n", "<leader>e", "<cmd>Ex<CR>", { desc = "[e]xplore current directory" })
k.set("n", "<leader>x", "<cmd>so %<CR>", { desc = "e[x]ecute current buffer" })
k.set("n", "<leader>h", ":vertical botright help ", { desc = "trigger [h]elp", silent = false })
k.set("n", "<leader>cd", "<cmd>cd %:h<CR>", { desc = "[c]hange [d]irectory" })
k.set("n", "n", "nzz", { desc = "center next match" })
k.set("n", "N", "Nzz", { desc = "center prev match" })
k.set("n", "#", "zt2<C-y>", { desc = "select and title it" })
k.set("n", "<leader>*", function()
	vim.fn.setreg("/", "\\%$\\%^")
end, { desc = "Reset search register" })
k.set("n", "<leader>'", function()
	vim.opt.wrap = not vim.opt.wrap
end, { desc = "switch wrap setting" })
k.set("n", "<leader>l", function()
	vim.opt.list = not vim.opt.list
end, { desc = "switch wrap setting" })

-- buffer mapping
k.set("n", "<leader>bb", "<cmd>buffers<CR>", { desc = "[b]uffers list" })
k.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "[b]uffer [n]ext" })
k.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "[b]uffer [p]revious" })
k.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "[b]uffer [d]elete" })

-- window mapping
k.set("n", "<leader>w", "<C-W>", { desc = "shortcut to [w]indow managment" })
k.set("n", "<leader>we", "<C-W>=", { desc = "[w]indow [e]qualize" })
k.set("n", "<leader>wt", "<C-W>T", { desc = "[w]indow in new [T]ab" })
k.set("n", "<leader>w-", "<C-W>5-", { desc = "[w]indow resize custom" })
k.set("n", "<leader>w+", "<C-W>5+", { desc = "[w]indow resize custom" })
k.set("n", "<leader>w<", "<C-W>5<", { desc = "[w]indow resize custom" })
k.set("n", "<leader>w>", "<C-W>5>", { desc = "[w]indow resize custom" })

-- tabs mapping
k.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "create new [t]ab" })

-- lsp integrated shortcut
local lsp = vim.lsp.buf
k.set("n", "gh", lsp.code_action, { desc = "[g]et [h]elp" })
k.set("n", "gd", lsp.definition, { desc = "[g]oto [d]efinition" })
k.set("n", "gD", lsp.declaration, { desc = "[g]oto [D]eclaration" })
k.set("n", "gr", lsp.references, { desc = "[g]oto [R]eference" })
k.set("n", "gR", lsp.rename, { desc = "[g]oto [R]ename" })
k.set("i", "<C-g><C-r>", lsp.rename, { desc = "trigger [g]oto [R]ename" })
k.set("i", "<C-h>", lsp.hover, { desc = "trigger [H]over" })

-- terminal mapping
k.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit from terminal" })

-- quickfix integrated
k.set("n", "<leader>co", "<cmd>cwindow 8<CR>", { desc = "open qflist" })
k.set("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "qflist next entry" })
k.set("n", "<leader>cj", "<cmd>cnext<CR>", { desc = "qflist next entry" })
k.set("n", "<leader>cp", "<cmd>cNext<CR>", { desc = "qflist prev entry" })
k.set("n", "<leader>ck", "<cmd>cNext<CR>", { desc = "qflist prev entry" })
k.set("n", "<leader>cf", "<cmd>cfirst<CR>", { desc = "qflist first entry" })
k.set("n", "<leader>cl", "<cmd>clast<CR>", { desc = "qflist last entry" })
k.set("n", "<leader>cm", "<cmd>make!<CR><cmd>cwindow 8<CR>", { desc = "open qflist" })

-- fold custom integration
k.set("i", "<C-o>", "<cmd>FoldToggle<CR>", { desc = "trigger f[O]ldtoggle command" })

-- moving capabilities
k.set("n", "<M-k>", "<cmd>m .-2<CR>==", { desc = "move up row" })
k.set("n", "<M-j>", "<cmd>m .+1<CR>==", { desc = "move down row" })
k.set("v", "<M-j>", ":'<,'>m '>+1<CR>gv=gv", { desc = "move selection down" })
k.set("v", "<M-k>", ":'<,'>m '<-2<CR>gv=gv", { desc = "move selection up" })

-- lua eval
local function lua_eval()
	local s = vim.fn.getpos("v")
	local e = vim.fn.getpos(".")
	-- ensure ordering
	if s[2] > e[2] or (s[2] == e[2] and s[3] > e[3]) then
		s, e = e, s
	end
	local lines = vim.api.nvim_buf_get_text(0, s[2] - 1, s[3] - 1, e[2] - 1, e[3], {})
	local code = table.concat(lines, "\n")
	local fn, err = load(code)
	if fn then
		fn()
	else
		---@diagnostic disable-next-line: param-type-mismatch
		vim.notify(err, vim.log.levels.WARN)
	end
end

k.set("v", "<C-l>", lua_eval, { desc = "eval lua code" })
