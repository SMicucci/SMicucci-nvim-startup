local cmp = require('cmp')

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
}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
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
--		['<Space>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
--		{ { name = 'html-css', option = { enable_on = { 'html' }, style_sheets ={ 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' } } } },
		{ name = 'treesitter' },
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, 
		{ name = 'buffer' },
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
				latex_symbols = "[Latex]"
			})[entry.source.name]
			return vim_item
		end
	},
	experimental = { ghost_text = true },
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline( ':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	},
	{
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
	experimental = { ghost_text = true },
})

