local cmp = require("blink.cmp")

---@diagnostic disable-next-line: undefined-field
cmp.build():wait(60000)

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	enabled = function()
		return not vim.tbl_contains({
			"markdown",
			"dap-repl",
		}, vim.bo.filetype)
	end,
	signature = { enabled = true },
	sources = {
		default = { "lsp", "path", "snippets" },
		per_filetype = {
			lua = { inherit_defaults = true, "lazydev" },
			cs = { inherit_defaults = true, "easy-dotnet" },
			razor = { inherit_defaults = true, "easy-dotnet" },
			vb = { inherit_defaults = true, "easy-dotnet" },
			AgenticInput = { "agentic_slash", "agentic_at" },
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
			["easy-dotnet"] = {
				enabled = true,
				name = "easy-dotnet",
				module = "easy-dotnet.completion.blink",
				score_offset = 10000,
				async = true,
			},
			agentic_slash = {
				module = "blink.cmp.sources.complete_func",
				name = "AgenticSlash",
				opts = {
					complete_func = function()
						return "v:lua.adjust_slash_complete"
					end,
				},
			},
			agentic_at = {
				module = "blink.cmp.sources.complete_func",
				name = "AgenticAt",
				-- `@` at line start or after whitespace, skips emails and a@b paths
				enabled = function()
					local prefix = vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2])
					return prefix:match("^@%S*$") ~= nil or prefix:match("%s@%S*$") ~= nil
				end,
				opts = {
					complete_func = function()
						return "v:lua.require('agentic.ui.file_picker').complete_func"
					end,
				},
			},
		},
	},
	completion = { keyword = { range = "full" } },
	snippets = { preset = "luasnip" },
	cmdline = { keymap = { preset = "default" } },
	-- terminal = { keymap = { preset = 'default' }, },
	fuzzy = { implementation = "prefer_rust" },
})

require("nvim-autopairs").setup({ check_ts = true })
