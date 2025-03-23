return {
  "williamboman/mason.nvim",
  config = function ()
    local mauto = require 'mason-automation'
    local mason = require 'mason'
---@diagnostic disable-next-line: missing-fields
    mason.setup {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }
    }

    local capabilities = require "blink.cmp".get_lsp_capabilities()
    mauto.lsp_set_default { capabilities = capabilities, }

    --lspconfig name or mason name are equivalent here
    mauto.install {
      'clangd',
      'codelldb', --dap can be installed here too
      'cssls',
      'html',
      'jsonls',
      'lua_ls',
      'tailwindcss',
      'ts_ls',
      'gopls',
      'delve',
      'sqlls',
    }
  end
}
