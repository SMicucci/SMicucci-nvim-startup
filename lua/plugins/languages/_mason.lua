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
      'codelldb', --dap can be installed here too
      'delve',
      'clangd',
      'cssls',
      'jsonls',
      'lua_ls',
      'ts_ls',
      'sqlls',
    }

    --{{{# web setup
---@diagnostic disable-next-line: missing-fields
    mauto.lsp_set_custom('html',{
      filetypes = { 'html', 'gotmpl', 'tmpl', 'razor', 'cshtml', 'ejs' }
    })
---@diagnostic disable-next-line: missing-fields
    mauto.lsp_set_custom('tailwindcss',{
      filetypes = { 'html', 'gotmpl', 'tmpl', 'razor', 'cshtml' }
    })
---@diagnostic disable-next-line: missing-fields
    mauto.lsp_set_custom('ts_ls',{
      filetypes = { 'javascript', 'typescript', 'ejs' }
    })
    --}}}
  end
}
