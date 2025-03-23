return {
  'VidocqH/lsp-lens.nvim',
  config = function()
    local lens = require "lsp-lens"
    local util = require "lsp-lens.lens-util"
    -- local auto = require 'config.command'
    local k = require "config.keymap"


    lens.setup{
      enable = true,
      sections = {
        definition = function (c) return " Def: " .. c end,
        references = function (c) return "󰅪 Ref: " .. c end,
        implements = function (c) return "󰅩 Impl: " .. c end,
      },
    }
    util.lsp_lens_off({})

    vim.api.nvim_set_hl(0, "LspLens", { link = "Visual", force = true })
    -- local autogroup = auto.aug('lspconfig', { clear = true })
    -- auto.au({'CursorHold', 'CursorHoldI'}, {
    --   group = autogroup,
    --   callback = function ()
    --     util.lsp_lens_on({})
    --   end,
    --   desc = 'enable inlay hint on stop'
    -- })
    -- auto.au({'CursorMoved', 'CursorMovedI'}, {
    --   group = autogroup,
    --   callback = function ()
    --     util.lsp_lens_off({})
    --   end,
    --   desc = 'disable inlay hint on move'
    -- })

    k.nmap("gl", util.lsp_lens_toggle, "code lens UI")
  end
}
