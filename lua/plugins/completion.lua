local use_blink = true
return {
  ---{{{ nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    enabled = not use_blink,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      {
        "l3mon4d3/luasnip",
        version = "v2.*",
        build = "make install_jsregexp"
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          check_ts = true,
          ts_config = {
            lua = {'string'},
            javascipt = {'template_string'},
            java = false,
          }
        }
      }
    },
    opts = function()
      local cmp = require'cmp'

      local kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
        Copilot = "",
      }

      local has_words_before = function ()
        if vim.api_nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.scroll_docs(-4),
          ['<C-k>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = vim.schedule_wrap(function (fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        }),
        sources = cmp.config.sources({
          -- { name = 'copilot' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },{
          { name = 'treesitter' },
        }),
        formatting = {
          format = function (entry, vim_item)
            --	kind icon
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            --	source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
              copilot = "[4o-mini]"
            })[entry.source.name]
            return vim_item
          end
        },
        experimental = { ghost_text = false },
      })

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

      --	inserting in autocompletion (?)
      local npairs = require("nvim-autopairs.completion.cmp")
      local ts_utils = require("nvim-treesitter.ts_utils")

      local ts_node_func_parens_disabled = {
        named_imports = true,
        use_declaration = true,
      }

      local default_handler = npairs.filetypes["*"]["("].handler
      npairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
        local node_type = ts_utils.get_node_at_cursor():type()
        if ts_node_func_parens_disabled[node_type] then
          if item.data then
            item.data.funcParensDisabled = true
          else
            char = ""
          end
        end
        default_handler(char, item, bufnr, rules, commit_character)
      end

      cmp.event:on(
        "confirm_done",
        npairs.on_confirm_done({
          sh = false,
        })
      )

    end
  },
  ---}}}

  {
    "Saghen/blink.cmp",
    enabled = use_blink,
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        "l3mon4d3/luasnip",
        version = "v2.*",
        build = "make install_jsregexp"
      },
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
    },
    -- version = "*",
    tag = 'v0.9.2',
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
        default = { 'lsp', 'path', 'luasnip', 'buffer' },
        cmdline = {},
      },
    },
  },
}
