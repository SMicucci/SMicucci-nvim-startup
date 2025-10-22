local M = {}

local lspconf = vim.lsp.config
local registry = require("mason-registry")
local dict = require("mason-automation.dictionary")

---@description default lsp config setup
local default_setup = nil
---@description table of custom lsp setup per each lsp name
local custom_setups = {}
---@description lsp custom autogroup to start lsp
local lsp_augroup = vim.api.nvim_create_augroup("mason_automation_lsp", { clear = false })

local warn_ = vim.log.levels.WARN

---init lsp: load configuration initialize filetypes, load autocmd to start lsp
---@param lsp_name any
local function init_lsp(lsp_name)
	if default_setup == nil then
		vim.notify("default_setup configuration missing...", warn_)
		default_setup = {}
	end
	local cfg = lspconf[lsp_name]
	if not cfg then
		return
	end
	local lsp_setup = vim.tbl_deep_extend("force", default_setup, custom_setups[lsp_name] or {})
	local ft_tbl = cfg.filetypes or {}
	-- insert custom filetype in cfg
	if lsp_setup.filetypes then
		for _, ft in ipairs(lsp_setup.filetypes) do
			if not vim.tbl_contains(ft_tbl, ft) then
				table.insert(ft_tbl, ft)
			end
		end
	end
	-- insert name in the config
	lsp_setup.name = lsp_name
	-- launch lsp with autocmd
	vim.api.nvim_create_autocmd("FileType", {
		group = lsp_augroup,
		pattern = ft_tbl,
		once = true,
		callback = function()
			-- prevent duplicate
			for _, client in ipairs(vim.lsp.get_clients() or {}) do
				if client.name == lsp_name then
					return
				end
			end
			-- start lsp
			vim.lsp.start(lsp_setup)
		end,
		desc = "mason-automation: init " .. lsp_name,
	})
	-- end)
end

---set default LSP configuration
---@param tbl table
function M.set_default(tbl)
	if default_setup == nil then
		default_setup = tbl or {}
	end
end

---set custom LSP configuration, parameter will be overwritten to default
---@param name string
---@param tbl table
function M.set_custom(name, tbl)
	local lsp_name = dict.lsp_name(name) or name
	custom_setups[lsp_name] = tbl or {}
	-- async execution
	vim.schedule(function()
		local waited = 0
		local max_wait = 2000
		local slept = 50
		if not lspconf[lsp_name] and waited < max_wait then
			vim.wait(slept)
			waited = waited + slept
		end
		if not lspconf[lsp_name] then
			vim.notify(lsp_name .. " missing config")
		else
			init_lsp(lsp_name)
		end
	end)
end

function M.prepare_installed()
	for _, pkg in ipairs(registry.get_installed_package_names()) do
		local lsp_name = dict.lsp_name(pkg)
		if lsp_name and not custom_setups[lsp_name] then
			vim.schedule(function()
				local waited = 0
				local max_wait = 2000
				local slept = 50
				if not lspconf[lsp_name] and waited < max_wait then
					vim.wait(slept)
					waited = waited + slept
				end
				if not lspconf[lsp_name] then
					vim.notify(lsp_name .. " missing config")
				else
					init_lsp(lsp_name)
				end
			end)
		end
	end
end

return M
