local cmp = require("blink.cmp")

---@diagnostic disable-next-line: undefined-field
cmp.build():wait(60000)

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	enabled = function()
		return not vim.tbl_contains({
			"markdown",
			"dap-repl",
			"AgenticInput",
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
		},
	},
	completion = { keyword = { range = "full" } },
	snippets = { preset = "luasnip" },
	cmdline = { keymap = { preset = "default" } },
	-- terminal = { keymap = { preset = 'default' }, },
	fuzzy = { implementation = "prefer_rust" },
})

require("nvim-autopairs").setup({ check_ts = true })
