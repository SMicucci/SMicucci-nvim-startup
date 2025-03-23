local M = {}

local mason = require 'mason-registry'
local dict = require 'mason-automation.dictionary'
local lsp = require 'mason-automation.lsp-manager'

M.install = function (pkg_name)
  assert(type(pkg_name) == 'string' or type(pkg_name) == 'table', 'expected string or table of string as argument')
  if type(pkg_name) == 'string' then
    pkg_name = {pkg_name}
  end
  for _, mason_name in ipairs(pkg_name) do
    assert(type(mason_name) == 'string', 'expected string or table of string as argument')
    mason_name = dict.mason_name(mason_name) or mason_name
    local pkg = mason.get_package(mason_name)
    assert(pkg, string.format('<%s> not a valid package name', pkg_name))
    if not pkg:is_installed() then
      pkg:install()
    end
    if pkg.spec.categories[1] == "LSP" then
      lsp.prepare_installed()
    end
  end
end

return M
