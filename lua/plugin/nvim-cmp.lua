if (vim.g.plugs["nvim-cmp"] ~= nil) then
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
		Copilot = "",
	}

	--	copilot setup
	local has_words_before = function ()
		if vim.api-nvim_buf_get_option(0, "buftype") == "prompt" then return false end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
	end

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
			['<Tab>'] = vim.schedule_wrap(function (fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end),
		}),
		sources = cmp.config.sources({
			--		{ { name = 'html-css', option = { enable_on = { 'html' }, style_sheets ={ 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' } } } },
			{ name = 'copilot' },
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
					latex_symbols = "[Latex]",
					copilot = "[GPT-4m]"
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
end
