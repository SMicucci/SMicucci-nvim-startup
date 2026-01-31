local M = {}
-- # function definition
---simple keymap normal mode (re)set
---@param keys string lhs
---@param command function|string rhs
---@param desc string description
---@param opts table|nil other option (like silent)
M.nmap = function(keys, command, desc, opts)
	opts = opts or {}
	if vim.fn.maparg(keys, "n") ~= "" and not opts.buffer then
		vim.keymap.del("n", keys)
	end
	assert(not opts.desc, "keymap desc must be assigned on argument")
	opts.desc = desc
	vim.keymap.set("n", keys, command, opts)
end
---simple keymap visual mode (re)set
---@param keys string lhs
---@param command function|string rhs
---@param desc string description
---@param opts table|nil other option (like silent)
M.vmap = function(keys, command, desc, opts)
	opts = opts or {}
	if vim.fn.maparg(keys, "x") ~= "" and not opts.buffer then
		vim.keymap.del("x", keys)
	end
	assert(not opts.desc, "keymap desc must be assigned on argument")
	opts.desc = desc
	vim.keymap.set("x", keys, command, opts)
end
---simple keymap insert mode (re)set
---@param keys string lhs
---@param command function|string rhs
---@param desc string description
---@param opts table|nil other option (like silent)
M.imap = function(keys, command, desc, opts)
	opts = opts or {}
	if vim.fn.maparg(keys, "i") ~= "" and not opts.buffer then
		vim.keymap.del("i", keys)
	end
	assert(not opts.desc, "keymap desc must be assigned on argument")
	opts.desc = desc
	vim.keymap.set("i", keys, command, opts)
end
---simple keymap select mode (re)set
---@param keys string lhs
---@param command function|string rhs
---@param desc string description
---@param opts table|nil other option (like silent)
M.smap = function(keys, command, desc, opts)
	opts = opts or {}
	if vim.fn.maparg(keys, "s") ~= "" and not opts.buffer then
		vim.keymap.del("s", keys)
	end
	assert(not opts.desc, "keymap desc must be assigned on argument")
	opts.desc = desc
	vim.keymap.set("s", keys, command, opts)
end
---simple keymap terminal mode (re)set
---@param keys string lhs
---@param command function|string rhs
---@param desc string description
---@param opts table|nil other option (like silent)
M.tmap = function(keys, command, desc, opts)
	opts = opts or {}
	if vim.fn.maparg(keys, "t") ~= "" and not opts.buffer then
		vim.keymap.del("t", keys)
	end
	assert(not opts.desc, "keymap desc must be assigned on argument")
	opts.desc = desc
	vim.keymap.set("t", keys, command, opts)
end

-- # default behaviour
M.nmap("<leader>q", "<cmd>q<CR>", "[q]uit")
M.nmap("<leader>s", "<cmd>w<CR>", "[s]ave")
M.nmap("<leader>e", "<cmd>Ex<CR>", "[e]xplore current directory")
M.nmap("<leader>x", "<cmd>so %<CR>", "e[x]ecute current buffer")
M.nmap("<leader>h", ":vertical botright help ", "trigger [h]elp", { silent = false })
M.nmap("n", "nzz", "center next match")
M.nmap("N", "Nzz", "center prev match")
M.nmap("#", "zt2<C-y>", "select and title it")
M.nmap("<leader>*", function()
	vim.fn.setreg("/", "\\%$\\%^")
end, "Reset search register")
M.nmap("<leader>'", function()
	---@diagnostic disable-next-line: undefined-field
	vim.opt.wrap = not vim.opt.wrap:get()
end, "switch wrap setting")
M.nmap("<leader>l", function()
	---@diagnostic disable-next-line: undefined-field
	vim.opt.list = not vim.opt.list:get()
end, "switch wrap setting")
M.nmap("<leader>z", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.foldmethod:get() == "marker" then
		vim.opt.foldmethod = "manual"
		vim.cmd("normal! zX zR")
		vim.notify("manual fold method (see fold.txt)")
	else
		vim.opt.foldmethod = "marker"
		vim.cmd("normal! zX zM")
		vim.notify("marker fold method [{{{,}}}] (see fold.txt)")
	end
end, "switch wrap setting")

-- buffer mapping
M.nmap("<leader>bb", "<cmd>buffers<CR>", "[b]uffers list")
M.nmap("<leader>bn", "<cmd>bn<CR>", "[b]uffer [n]ext")
M.nmap("<leader>bp", "<cmd>bp<CR>", "[b]uffer [p]revious")
-- this is a bit sofisticated (split, prev buf, next win, del buf)
-- M.nmap('<leader>bd','<C-W>s<cmd>bp<CR><C-W>w<cmd>bd<CR>','[b]uffer [d]elete')
M.nmap("<leader>bd", "<cmd>bd<CR>", "[b]uffer [d]elete")

-- window mapping
M.nmap("<leader>w", "<C-W>", "shortcut to [w]indow managment")
M.nmap("<leader>we", "<C-W>=", "[w]indow [e]qualize")
M.nmap("<leader>wt", "<C-W>T", "[w]indow in new [T]ab")
M.nmap("<leader>w-", "<C-W>5-", "[w]indow resize custom")
M.nmap("<leader>w+", "<C-W>5+", "[w]indow resize custom")
M.nmap("<leader>w<", "<C-W>5<", "[w]indow resize custom")
M.nmap("<leader>w>", "<C-W>5>", "[w]indow resize custom")

-- tabs mapping
M.nmap("<leader>tn", "<cmd>tabnew<CR>", "create new [t]ab")

-- lsp integrated shortcut
local lsp = vim.lsp.buf
M.nmap("gh", lsp.code_action, "[g]et [h]elp")
M.nmap("gd", lsp.definition, "[g]oto [d]efinition")
M.nmap("gD", lsp.declaration, "[g]oto [D]eclaration")
M.nmap("gr", lsp.references, "[g]oto [R]eference")
M.nmap("gR", lsp.rename, "[g]oto [R]ename")
M.imap("<C-g><C-r>", lsp.rename, "trigger [g]oto [R]ename")
M.imap("<C-h>", lsp.hover, "trigger [H]over")

-- terminal mapping
M.tmap("<Esc>", "<C-\\><C-n>", "exit from terminal")

-- quickfix integrated
M.nmap("<leader>co", "<cmd>cwindow 8<CR>", "open qflist")
M.nmap("<leader>cn", "<cmd>cnext<CR>", "qflist next entry")
M.nmap("<leader>cj", "<cmd>cnext<CR>", "qflist next entry")
M.nmap("<leader>cp", "<cmd>cNext<CR>", "qflist prev entry")
M.nmap("<leader>ck", "<cmd>cNext<CR>", "qflist prev entry")
M.nmap("<leader>cf", "<cmd>cfirst<CR>", "qflist first entry")
M.nmap("<leader>cl", "<cmd>clast<CR>", "qflist last entry")
M.nmap("<leader>cm", "<cmd>make!<CR><cmd>cwindow 8<CR>", "open qflist")

-- fold custom integration
-- M.nmap('<C-o>','<cmd>FoldToggle<CR>','trigger f[O]ldtoggle command')
M.imap("<C-o>", "<cmd>FoldToggle<CR>", "trigger f[O]ldtoggle command")

-- # moving capabilities
M.nmap("<M-k>", "<cmd>m .-2<CR>==", "move up row")
M.nmap("<M-j>", "<cmd>m .+1<CR>==", "move down row")
M.vmap("<M-j>", ":'<,'>m '>+1<CR>gv=gv", "move selection down")
M.vmap("<M-k>", ":'<,'>m '<-2<CR>gv=gv", "move selection up")

-- export functions
return M
