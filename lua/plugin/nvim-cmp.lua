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

	--	check if autopairs is installed and initialize
	if (vim.g.plugs["nvim-autopairs"] ~= nil and vim.g.plugs["nvim-treesitter"] ~= nil) then
		--	setting plugin
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = {'string'},
				javascipt = {'template_string'},
				java = false,
			}
		})

		--	add same rule for '<>'
		require("nvim-autopairs").add_rule(require("nvim-autopairs.rule")('<', '>', {
			'-html',
			'-javascriptreact',
			'-typescriptreact',
		}):with_pair(
			require("nvim-autopairs.conds").before_regex('%a+:?:?$', 3)
		):with_move(function(opts)
			return opts.char =='>'
		end))

		--	inserting in autocompletion (?)
		local npairs = require("nvim-autopairs.completion.cmp")
		local ts_utils = require("nvim-treesitter.ts_utils")

		local ts_node_func_parens_disabled = {
			-- ecma
			named_imports = true,
			-- rust
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
end
