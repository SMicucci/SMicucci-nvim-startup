return {
  "l3mon4d3/luasnip",
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = "v2.*",
  build = "make install_jsregexp",
  opts = function ()
    require 'luasnip.loaders.from_vscode'.lazy_load()
    require 'luasnip.loaders.from_snipmate'.lazy_load()
    require 'luasnip.loaders.from_lua'.lazy_load()

    local fte = require('luasnip').filetype_extend
    local fts = require('luasnip').filetype_set
    fte('c', { 'cdoc' })
    fte('cs', { 'csharpdoc' })
    fte('razor', { 'csharp', 'csharpdoc', 'html', 'javascript', 'jsdoc', })
    fte('lua', { 'luadoc' })
    fte('javascript', { 'jsdoc' })
    fte('typescript', { 'tsdoc' })
    fte('go', { 'go' })
    fte('templ', { 'go', 'html' })
    fte('gohtmltmpl', { 'go', 'html' })

    -- fts('cshtml', 'razor')
    -- require 'plugins.settings.luasnip'

    local keymap = require 'config.keymap'
    local ls = require 'luasnip'
    -- require 'plugins.settings.luasnip'
    keymap.imap('<C-n>', function () ls.jump(1) end, 'luasnip jump to [N]ext entry')
    keymap.smap('<C-n>', function () ls.jump(1) end, 'luasnip jump to [N]ext entry')
    keymap.imap('<C-p>', function () ls.jump(-1) end, 'luasnip jump to [P]revious entry')
    keymap.smap('<C-p>', function () ls.jump(-1) end, 'luasnip jump to [P]revious entry')
    keymap.imap('<C-k>', ls.expand, 'luasnip jump to [N]ext entry')
  end,
}
