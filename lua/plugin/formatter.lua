local k = vim.keymap

local initialized = false

local function setup_conform()
	if initialized then
		return
	end
	initialized = true

	-- setup formatter
	require("conform").setup({
		formatters_by_ft = {
			c = { "clang_format_custom" },
			go = { "goimports", "gofmt" },
			javascript = { "prettier_js" },
			typescript = { "prettier_ts" },
			html = { "prettier" },
			razor = { "prettier" },
			json = { "fixjson" },
			lua = { "stylua" },
			templ = { "templ" },
			cs = { "csharpier_custom" },
			["*"] = function(bufnr)
				if vim.bo[bufnr].filetype ~= "markdown" then
					return { "trim_whitespace" }
				end
				return {}
			end,
		},
		formatters = {
			clang_format_custom = {
				command = "clang-format",
				args = {
					"-assume-filename",
					"$FILENAME",
					"--style={BasedOnStyle: llvm, IndentWidth: 8, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 80}",
				},
			},
			prettier_js = {
				command = "prettier",
				args = {
					"--stdin-filepath",
					"$FILENAME",
					"--tab-width",
					"2",
					"--semi",
					"true",
					"--single-quote",
					"false",
					"--print-width",
					"100",
				},
			},
			prettier_ts = {
				command = "prettier",
				args = {
					"--stdin-filepath",
					"$FILENAME",
					"--tab-width",
					"2",
					"--semi",
					"true",
					"--single-quote",
					"false",
					"--print-width",
					"80",
				},
			},
			csharpier_custom = {
				command = function()
					if vim.g.is_win then
						return vim.fn.expand("$MASON/bin/csharpier.cmd")
					else
						return vim.fn.expand("$MASON/bin/csharpier")
					end
				end,
			},
		},
	})
end

k.set("n", "<leader>fw", function()
	setup_conform()
	require("conform").format({ bufnr = 0, lsp_format = "fallback", stop_after_first = true })
end, { desc = "conform format file" })

-- minify with esbuild
vim.api.nvim_create_user_command("Minify", function()
	local file = vim.fn.expand("%:p")
	local ext = vim.fn.expand("%:e")
	local root = vim.fn.expand("%:r")
	local out_file = root .. ".min." .. ext
	if ext ~= "js" and ext ~= "css" then
		vim.notify("Minify only supports .js and .css files", vim.log.levels.WARN)
		return
	end
	local cmd = { "esbuild", file, "--minify", "--outfile=" .. out_file }
	vim.system(cmd, { text = true }, function(obj)
		if obj.code == 0 then
			vim.schedule(function()
				vim.notify("Minified to: " .. out_file, vim.log.levels.INFO)
			end)
		else
			vim.schedule(function()
				vim.notify("Minify Error:\n" .. obj.stderr, vim.log.levels.ERROR)
			end)
		end
	end)
end, { range = true })
