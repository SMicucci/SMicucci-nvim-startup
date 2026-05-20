local go_group = vim.api.nvim_create_augroup("go_plugs", { clear = true })

local initialized = false

local function setup_go()
	if initialized then
		return
	end
	initialized = true

	require("go").setup()
end

vim.api.nvim_create_autocmd("FileType", {
	group = go_group,
	once = true,
	pattern = { "go", "gomod", "gowork", "gotmpl", "templ" },
	callback = function()
		setup_go()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = go_group,
	once = true,
	callback = function()
		local gomod = vim.fs.find(function(name)
			return name:match("go.mod$")
		end, { upward = true, type = "file" })
		if #gomod > 0 then
			setup_go()
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = go_group,
  pattern = "*.go",
    callback = function ()
      require("go.format").goimports()
    end,
})
