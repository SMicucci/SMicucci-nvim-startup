--@type LazyPlugin
--@diagnostic disable-next-line: missing-fields
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
			config = function()
				local mason = require("mason")
				---@diagnostic disable-next-line: missing-fields
				mason.setup({
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				})
			end,
		},
		{ "neovim/nvim-lspconfig", lazy = false },
	},
	config = function()
		---root_dir factory for LSP configuration
		---@param markers string[] list of filename or directory names to identify the project root
		---@return fun(bufnr: integer, on_dir:fun(root_dir?:string)) function compatible with LSP root_dir option
		local function make_root_dir(markers)
			return function(bufnr, on_dir)
				local filepath = vim.api.nvim_buf_get_name(bufnr)
				if filepath == "" then
					on_dir(nil)
					return
				end
				local function has_marker(d)
					for _, m in ipairs(markers) do
						local path = d .. "./" .. m
						if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
							return true
						end
					end
				end
				local function find_root(d)
					if has_marker(d) then
						return d
					end
					local parent = vim.fn.fnamemodify(d, ":h")
					if parent == d then
						return nil
					end
					return find_root(parent)
				end
				local dir = vim.fn.fnamemodify(filepath, ":p:h")
				local root = find_root(dir) or vim.fn.getcwd()
				on_dir(root)
			end
		end

		---@type vim.lsp.Config
		local default = {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
			root_dir = make_root_dir({ ".git", ".env", "package.json", "pyproject.toml" }),
		}
		vim.lsp.config("*", default)

		---@type string[]
		local other_req = {
			"gopls",
			"templ",
			"clangd",
			"cssls",
			"jsonls",
			"lua_ls",
			"sqlls",
			"roslyn",
			"netcoredbg",
			"delve",
			"clang-format",
			"prettier",
			"stylua",
			-- "node-debug2-adapter",
		}

		require("mason-lspconfig").setup()

		local clangd_cap = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
			offsetEncoding = { "utf-8" },
			general = { positionEncoding = { "utf-8" } },
		})
		vim.lsp.config("clangd", {
			capabilities = clangd_cap,
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "opencl" },
		})
		vim.lsp.enable("clangd")

		-- install package with mason directly
		local m = require("mason-registry")
		for _, pkg in ipairs(other_req) do
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

		--web setup
		vim.lsp.config("html", {
			filetypes = { "html", "gohtmltmpl", "templ", "razor", "cshtml", "ejs" },
		})
		vim.lsp.config("ts_ls", {
			filetypes = { "javascript", "typescript", "ejs" },
		})

		--lsp folding
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
	end,
}
