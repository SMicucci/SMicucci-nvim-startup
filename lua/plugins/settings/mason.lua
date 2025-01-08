local lspconfig = require "lspconfig"
local registry = require "mason-registry"
local translate = require "plugins.settings.mason-maps"

local M = {}

-- # autoinstall packages

---install via mason all the package `required`
---TODO: aliases not supported yet
---@param required table require string names of the packages
M.default_install = function (required)
  assert(type(required) == 'table', 'installer require a table as argument')
  for _, pkg_name in ipairs(required) do
    -- check package exist
    if not registry.has_package(pkg_name) then
      vim.notify('Package \'' .. pkg_name .. '\' not found on Mason registries\n', vim.log.levels.ERROR)
    else
      -- get package and install
      local pkg = registry.get_package(pkg_name)
      if not pkg:is_installed() then
        pkg:install()
        vim.notify('Installing "' .. pkg_name .. '" via Mason...\n', vim.log.levels.INFO)
      end
    end
  end
end

-- # setup lsp from config

---substitute mason-lspconfig setup_handler
---get default behaviour and override if required on it custom behaviour
---@param default_setup table? default behaviour like capabilities or other (overridable from custom)
---@param custom_setup_table table? contiain table or function of custmo behaviour for each lsp entry (mason or lspconfig name)
M.setup_lsp_server = function (default_setup, custom_setup_table)
  -- args are optional
  default_setup = default_setup or {}
  custom_setup_table = custom_setup_table or {}
  -- assert args
  assert(type(default_setup) == 'table', '"default_setup" is not a table')
  assert(type(custom_setup_table) == 'table', '"custom_setup_table" is not a table')
  -- iterate through every installed package
  for _, pkg in ipairs(registry.get_installed_packages()) do
    -- check if pkg is LSP
    if pkg.spec.categories[1] == "LSP" then
      -- override custom to default
      local name = translate.m2l(pkg.name)
      if name then
        custom_setup_table[name] = custom_setup_table[name] or {}
        assert(type(custom_setup_table[name]) == 'table', string.format('custom setup ["%s"] is not a table',name))
        local override_setup = vim.tbl_deep_extend('force',default_setup,custom_setup_table[name] or {})
        lspconfig[name].setup(override_setup)
      else
        name = pkg.name
        custom_setup_table[name] = custom_setup_table[name] or function() end
        assert(type(custom_setup_table[name]) == 'function', string.format('["%s"] require a function, not supported by _lspconfig_',name))
        -- vim.notify('eseguento la funzione per l\'LSP custom\n',vim.log.levels.INFO)
        pcall(custom_setup_table[name])
        -- vim.notify('funzione eseguita\n',vim.log.levels.INFO)
      end
    end
  end
end

-- # default behaviour settings with metatable

M.auto_update = false

-- metatable with default behaviour
local mtbl = {
  __newindex = function (tbl, key, value)
    if key == 'auto_update' and type(value) == 'boolean' and value then
      rawset(tbl, key, value)
      registry.update()
      vim.notify('Mason update packages...',vim.log.levels.INFO)
    else
      rawset(tbl, key, value)
    end
  end
}
-- install metatable
setmetatable(M,mtbl)

return M
