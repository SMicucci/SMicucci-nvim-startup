return {
	"williamboman/mason.nvim",
	config = function()
		local mauto = require("mason-automation")
		local mason = require("mason")
		---@diagnostic disable-next-line: missing-fields
		mason.setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		mauto.lsp_set_default({ capabilities = capabilities })

		--lspconfig name or mason name are equivalent here
		mauto.install({
			"delve",
			"clangd",
			"cssls",
			"jsonls",
			"lua_ls",
			-- "ts_ls",
			"sqlls",
		})

		--{{{# web setup
		---@diagnostic disable-next-line: missing-fields
		mauto.lsp_set_custom("html", {
			filetypes = { "html", "gohtmltmpl", "templ", "razor", "cshtml", "ejs" },
		})
		---@diagnostic disable-next-line: missing-fields
		mauto.lsp_set_custom("tailwindcss", {
			filetypes = { "html", "gohtmltmpl", "templ", "razor", "cshtml", "ejs" },
		})
		---@diagnostic disable-next-line: missing-fields
		mauto.lsp_set_custom("ts_ls", {
			filetypes = { "javascript", "typescript", "ejs" },
		})
		--}}}

		-- # header file fix
		local clangd_path =
			vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "mason", "bin", "clangd"))
		mauto.lsp_set_custom("clangd", {
			cmd = {
				clangd_path,
				"--fallback-style=-xc",
			},
		})
		--}}}

		--{{{# lsp folding
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
				if client ~= nil and client.supports_method("textDocument/foldingRange") then
					local win = vim.api.nvim_get_current_win()
					vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
				end
			end,
		})
		--}}}
	end,
}
