local M = {}

local lsp = require 'lspconfig'
local registry = require 'mason-registry'
local dict = require 'mason-automation.dictionary'

local custom_setups = {}
local default_setup = nil
local prepare_called = false

local lsp_augroup = vim.api.nvim_create_augroup('mason_automation_lsp', {clear = false})

--{{{# initialize lsp
local function lsp_init(lsp_name, default)
  lsp_name = dict.lsp_name(lsp_name) or lsp_name
  local ft_tbl = require('lspconfig.configs.'..lsp_name).default_config.filetypes
  local setup_ = vim.tbl_deep_extend('keep', custom_setups[lsp_name], default)
  --autocmd for each lsp
  vim.api.nvim_create_autocmd('FileType',{
    group = lsp_augroup,
    pattern = ft_tbl,
    once = true,
    callback = function ()
      if vim.tbl_contains(ft_tbl, vim.bo.filetype) then
        local lsp_clients = vim.lsp.get_clients() or {}
        for _, attached in ipairs(lsp_clients) do
          if attached.config.name == lsp_name then
            return
          end
        end
        lsp[lsp_name].setup(setup_)
        lsp[lsp_name].launch()
      end
    end,
    desc = 'mason-automation: init '..lsp_name,
  })
  -- print(string.format('"%s" => autocmd (Filetype: %s)', lsp_name, vim.inspect(ft_tbl)))
end
--}}}

--{{{#lsp coroutine
local function lsp_coroutine(arg)
  local t = type(arg)
  -- print('>> coroutine entered with ('..t..') as argument)')
  assert(t == 'string' or t == 'table', 'bad usage of <co_lsp> coroutine ',vim.inspect(arg))
  -- print('>> coroutine passed filter')
  local customs = {}

  while true do
    if not default_setup then -- waiting for default table
      if type(arg) == 'string' then
        -- print('>> coroutine waiting for default setup')
        table.insert(customs, dict.lsp_name(arg))
      else
        default_setup = arg
        -- print('>> coroutine setting default setup')
        for _, setup in ipairs(customs) do
          -- print('>> coroutine loading pending "'..setup..'"')
          lsp_init(setup, default_setup)
        end
      end
    else --default behaviour
      -- print('>> coroutine setting custom setup')
      lsp_init(arg, default_setup)
    end
    -- print('>> coroutine yield')
    arg = coroutine.yield()
    t = type(arg)
    assert(t == 'string' or t == 'table', 'bad usage of <co_lsp> coroutine ',vim.inspect(arg))
    -- print('>> coroutine continue with ('..t..') as argument)')
  end
end

local co_lsp = coroutine.create(lsp_coroutine)
--}}}

M.get_default = function()
  if not default_setup then
    vim.wait(20)
  end
  return default_setup
end

M.set_default = function (default)
  assert(type(default) == 'table' or default == nil, 'expected table as argument')
  coroutine.resume(co_lsp, default)
end

M.set_custom = function (name, custom)
  assert(type(name) == 'string', string.format('expected string as first argument:\n', vim.inspect(name)))
  assert(type(custom) == 'table', string.format('expected table as second argument:\n%s',vim.inspect(custom)))
  local lsp_name = dict.lsp_name(name) or name
  local is_nil = custom_setups[lsp_name] == nil
  local is_extend = custom_setups[lsp_name] == {} and #custom > 0
  if is_nil or is_extend then
    custom_setups[lsp_name] = custom
    require 'mason-automation.utils'.install(lsp_name)
  end
  if is_extend then
    vim.notify('double declaration for '..lsp_name, vim.log.levels.ERROR)
  end
  local ret, msg = coroutine.resume(co_lsp, lsp_name)
  assert(ret, msg)
end

M.prepare_installed = function()
  if prepare_called then
    return
  end
  prepare_called = true
  local installed = registry.get_installed_package_names()
  for _, pkg in ipairs(installed) do
    local lsp_name = dict.lsp_name(pkg)
    if lsp_name and custom_setups[lsp_name] == nil then
      M.set_custom(lsp_name, {}) --setup his space if nil
    end
  end
end

return M
