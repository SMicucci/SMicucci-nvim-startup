return {
  "Saghen/blink.cmp",
  dependencies = {
    'GustavEikaas/easy-dotnet.nvim',
    'l3mon4d3/luasnip',
    'windwp/nvim-autopairs',
  },
  version = "*",
  -- tag = 'v0.13.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function ()
      return not vim.tbl_contains({
        "markdown",
        "TelescopePrompt",
        "neo-tree",
        "neo-tree-popup",
        -- "codecompanion",
        "dap-repl",
      }, vim.bo.filetype)
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
      default = { 'lsp', 'path', 'snippets', 'buffer', 'easy-dotnet', },
      providers = {
        ['easy-dotnet'] = {
          enabled = true,
          name = 'easy-dotnet',
          module = 'easy-dotnet.completion.blink',
          score_offset = 10000,
          async = true,
        }
      }
    },
  },
}
