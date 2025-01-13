return {
  {
    "Saghen/blink.cmp",
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        "l3mon4d3/luasnip",
        version = "v2.*",
        build = "make install_jsregexp",
        opts = function ()
          require 'luasnip.loaders.from_vscode'.lazy_load()

          local keymap = require 'config.keymap'
          local ls = require 'luasnip'
          -- require 'plugins.settings.luasnip'
          keymap.imap('<C-n>', function () ls.jump(1) end, 'luasnip jump to [N]ext entry')
          keymap.smap('<C-n>', function () ls.jump(1) end, 'luasnip jump to [N]ext entry')
          keymap.imap('<C-p>', function () ls.jump(-1) end, 'luasnip jump to [P]revious entry')
          keymap.smap('<C-p>', function () ls.jump(-1) end, 'luasnip jump to [P]revious entry')
          keymap.imap('<C-k>', ls.expand, 'luasnip jump to [N]ext entry')
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = function ()
          --{{{
          require'nvim-autopairs'.setup{
            check_ts = true,
            ts_config = {
              lua = {'string'},
              javascipt = {'template_string'},
              java = false,
            }
          }
          -- # autopairs setup
          --	add same rule for '<>'
          require("nvim-autopairs").add_rule(
            require("nvim-autopairs.rule")('<', '>', {
              '-html',
              '-javascriptreact',
              '-typescriptreact',
            }):with_pair(
                require("nvim-autopairs.conds").before_regex('%a+:?:?$', 3)
              )
              :with_move(function(opts)
              return opts.char =='>'
            end))
          --}}}
        end
      },
    },
    version = "*",
    -- tag = 'v0.9.2',
    opts = {

      keymap = {
        preset = 'default',
        ['<Enter>'] = { 'select_and_accept', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
        ['<M-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<S-Tab>'] = {},
        ['<C-h>'] = { 'show_documentation', 'hide_documentation' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
      snippets = {
        preset = 'luasnip',
        expand = function (snippet) require'luasnip'.lsp_expand(snippet) end,
        active = function (filter)
          if filter and filter.direction then
            return require'luasnip'.jumpable(filter.direction)
          end
          return require'luasnip'.in_snippet()
        end,
        jump = function (direction) require'luasnip'.jump(direction) end,
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        cmdline = {},
      },
    },
  },
}
