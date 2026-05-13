vim.api.nvim_create_autocmd("PackChanged", {
	desc = "blink build",
	callback = function(ev)
		-- filter out delete
		local spec = ev.data.spec
		local kind = ev.data.kind -- "install" | "update" | "delete"
		if kind ~= "install" and kind ~= "update" then
			return
		end

		--[[ nvim-treesitter ]]
		if spec.name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		end
	end,
})

vim.api.nvim_create_user_command("PackUpgrade", function()
	vim.schedule(function()
        vim.notify("PackUpgrade: updating plugins...", vim.log.levels.INFO)
		local ok, err = pcall(vim.pack.update, nil, { force = true })
        if ok then
            vim.notify("PackUpgrade: done", vim.log.levels.INFO)
        else
            vim.notify("PackUpgrade failed:u ".. err, vim.log.levels.ERROR)
        end
	end)
end, { desc = "update plugins async" })
