local k = vim.keymap

-- mason
require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
})

-- treesitter
require("nvim-treesitter").install({ "c", "lua", "html", "css", "javascript", "markdown" })

-- lazydev
require("lazydev").setup({
	library = { path = "${3rd}/luv/library", words = { "vim%.uv" } },
})

-- diagnostic
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	virtual_lines = {
		current_line = true,
	},
	severity_sort = true,
    underline = false,
    float = { border = "rounded", source = true }
})

-- codelens
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method("textDocument/codeLens") then
-- 			vim.lsp.codelens.enable(true, { bufnr = ev.buf })
-- 		end
-- 	end,
-- })
k.set("n", "gl", function()
			vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
		end, {desc = "lsp toggle codelens"})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	root_markers = { ".git", ".env", "package.json", "pyproject.toml" },
	-- root_dir = make_root_dir({ ".git", ".env", "package.json", "pyproject.toml" }),
})

---@type string[]
local mason_paq = {
	"gopls",
	"templ",
	"clangd",
	"css-lsp",
	"json-lsp",
	"lua-language-server",
	"sqlls",
	"roslyn",
	"netcoredbg",
	"delve",
	"clang-format",
	"prettier",
	"stylua",
}

-- lsp auto
require("mason-lspconfig").setup({ automatic_enable = true })

-- clang
local clangd_cap = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
	offsetEncoding = { "utf-8" },
	general = { positionEncoding = { "utf-8" } },
})
vim.lsp.config("clangd", {
	capabilities = clangd_cap,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "opencl" },
})

-- gopls
vim.lsp.config("gopls", {
    settings = {
        gopls = {
            codelenses = {
                gc_details = true,
                generate = true,
                tidy = true,
            },
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
        }
    }
})

-- install package with mason directly
local m = require("mason-registry")
for _, pkg in ipairs(mason_paq) do
	if m.has_package(pkg) == false then
		vim.notify(pkg .. " does not exist, check config", vim.log.levels.WARN)
		goto continue
	end
	if m.is_installed(pkg) then
		goto continue
	end
	m.get_package(pkg):install()
	::continue::
end

-- web setup
vim.lsp.config("html", {
	filetypes = { "html", "gohtmltmpl", "templ", "razor", "cshtml", "ejs" },
})
vim.lsp.config("ts_ls", {
	filetypes = { "javascript", "typescript", "ejs" },
})

-- lsp folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
		if client ~= nil and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})
