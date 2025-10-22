local M = {}

local lsp = require("mason-automation.lsp-manager")
local utils = require("mason-automation.utils")

M.lsp_set_default = lsp.set_default
M.lsp_get_default = lsp.get_default
M.lsp_set_custom = lsp.set_custom
M.install = utils.install

return M
