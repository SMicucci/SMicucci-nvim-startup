return {
  {
    "Saghen/blink.cmp",
    dependencies = {
      'rafamadriz/friendly-snippets',
      --{{{ ## luasnip
      {
        "l3mon4d3/luasnip",
        version = "v2.*",
        build = "make install_jsregexp",
        opts = function ()
          require 'luasnip.loaders.from_vscode'.lazy_load()
          require 'luasnip.loaders.from_snipmate'.lazy_load()
          require 'luasnip.loaders.from_lua'.lazy_load()

          local fe = require('luasnip').filetype_extend
          fe('c', { 'cdoc' })
          fe('cs', { 'csharpdoc' })
          fe('lua', { 'luadoc' })
          fe('javascript', { 'jsdoc' })
          fe('typescript', { 'tsdoc' })

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
      },
      --}}}
      --{{{ ## nvim-autopairs
      {
        "windwp/nvim-autopairs",
        opts = function ()
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
        end
      },
      --}}}
      --{{{## easy-dotnet
      {
        'GustavEikaas/easy-dotnet.nvim',
        -- opts = function ()
        --   local dotnet = require 'easy-dotnet'
        --   local  blink = require 'blink.cmp'
        --   blink.add_provider('easy-dotnet', dotnet.package_completion_source)
        -- end
      },
      --}}}
    },
    version = "*",
    -- tag = 'v0.10.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function ()
        return not vim.tbl_contains({'markdown', 'codecompanion', 'TelescopePrompt'},
          vim.bo.filetype) and vim.b.completion ~= false
      end,

      enabled = function ()
        return not vim.tbl_contains({
          "markdown",
          "TelescopePrompt",
          "codecompanion",
          "dap-repl",
        }, vim.bo.filetype) and vim.b.completion ~= false
      end,

      keymap = {
        preset = 'default',
        ['<Enter>'] = { 'select_and_accept', 'fallback' },
        ['<C-space>'] = { 'show', 'fallback' },
        ['<M-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<S-Tab>'] = {},
        ['<Tab>'] = {},
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-h>'] = { 'show_signature', 'hide_signature' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
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

      cmdline = { enabled = false, },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer',
          -- 'easy-dotnet',
        },
        -- providers = {
        --   ['easy-dotnet'] = {
        --     name = 'easy-dotnet',
        --     module = 'blink.cmp.source',
        --     enabled = function ()
        --       return vim.tbl_contains({'xml'}, vim.bo.filetype)
        --     end,
        --   },
        -- },
      },
    },
  },
}
