local lspconfig = require "lspconfig"
local registry = require "mason-registry"
local translate = require "plugins.settings.mason-maps"

local M = {}

-- # autoinstall packages

---@param required table require string names of the packages
M.default_install = function(required)
  assert(type(required) == 'table', 'installer require a table as argument')
  vim.schedule(
    function()
      for _, pkg_name in ipairs(required) do
        if not registry.has_package(pkg_name) then
          vim.notify('Package \'' .. pkg_name .. '\' not found on Mason registries\n', vim.log.levels.ERROR)
        else
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
            vim.notify('Installing "' .. pkg_name .. '" via Mason...\n', vim.log.levels.INFO)
          end
        end
      end
    end
  )
end

-- # setup lsp from config

local default_setup_table = nil
local custom_setup_tables = {}

---set default behaviour of every LSP, even custom one
---@param default table
M.lsp_setup_default = function (default)
  assert(type(default) == 'table', 'expected a table as "default" parameter')
  assert(default_setup_table == nil, 'override not expected')
  default_setup_table = default
end

---return default lsp behaviour
---@return table
M.get_lsp_default = function ()
  return default_setup_table --[[@as table]]
end

---set custom behaviour of this LSP
---@param name string
---@param config table
M.lsp_setup_custom = function (name, config)
  assert(type(name) == 'string', 'expected a string as "name" parameter')
  assert(type(config) == 'table', 'expected a table as "config" parameter')
  assert(custom_setup_tables[name] == nil, 'override not expected')
  custom_setup_tables[name] = config
end

-- # run lsp setted up

M.setup_lsp_server = function ()
  default_setup_table = default_setup_table or {}
  for _, pkg in ipairs(registry.get_installed_packages()) do
    if pkg.spec.categories[1] == "LSP" then
      local name = translate.m2l(pkg.name)
      if name then
        custom_setup_tables[name] = custom_setup_tables[name] or {}
        assert(type(custom_setup_tables[name]) == 'table', string.format('custom setup ["%s"] is not a table',name))
        local override_setup = vim.tbl_deep_extend('force',default_setup_table,custom_setup_tables[name] or {})
        lspconfig[name].setup(override_setup)
      else
        name = pkg.name
        custom_setup_tables[name] = custom_setup_tables[name] or function() end
        assert(type(custom_setup_tables[name]) == 'function', string.format('["%s"] require a function, not supported by _lspconfig_',name))
        pcall(custom_setup_tables[name])
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
