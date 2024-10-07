if ( vim.g.plugs["auto-session"] ~= nil ) then
	require("auto-session").setup {
		auto_restore = false,
		auto_save = false,
		auto_create = false,
		suppressed_dirs = { "~/", "/", "~/Downloads" },
		use_git_branch = true,
		bypass_save_filetypes = { 'alpha', 'dashboard' }
	}
	vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
end
