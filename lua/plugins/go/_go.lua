return {
	"https://github.com/ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	event = { "CmdlineEnter" },
	ft = { "go", "gomod", "gohtmltmpl", "templ" },
	build = ':lua require("go.install").update_all_sync()',
	config = function()
		require("go").setup()

		local k = require("config.keymap")
		local auto = require("config.command")
		local mauto = require("mason-automation")

		k.nmap("<space>go", "<cmd>GoPkgOutline<cr>", "toggle project package and API", { silent = true })

		local go_group = auto.aug("GoFormat", {})

		auto.au("BufWritePre", {
			pattern = "*.go",
			group = go_group,
			callback = function()
				require("go.format").goimports()
			end,
			desc = "Go auto import and format before write",
		})

		mauto.install("templ")
		---@diagnostic disable-next-line: missing-fields
		mauto.lsp_set_custom("gopls", {
			filetypes = { "go" },
		})
	end,
}
