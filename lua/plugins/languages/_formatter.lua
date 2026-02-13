return {
	"stevearc/conform.nvim",
	cmd = { "ConfortInfo", "Minify" },
	keys = {
		{
			"<leader>fw",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format file explicitly",
		},
	},
	config = function()
		-- Utilities for creating configurations
		local auto = require("config.command")
		local k = require("config.keymap")
		local confort = require("conform")

		local format_group = auto.aug("format", { clear = true })

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		confort.setup({
			formatters_by_ft = {
				c = { "clang_format_custom" },
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
				end,
			},
			formatters = {
				clang_format_custom = {
					command = "clang-format",
					args = {
						"-assume-filename",
						"$FILENAME",
						"-style='{BasedOnStyle: llvm, IndentWidth: 8, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 80}'",
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
						local res = {
							exe = vim.fn.expand("$MASON/bin/csharpier"),
							args = { "format" },
							stdin = true,
						}
						if vim.g.is_win then
							return vim.fn.expand("$MASON/bin/csharpier.cmd")
						else
							return vim.fn.expand("$MASON/bin/csharpier")
						end
					end,
				},
				esbuild_minify = {
					command = "esbuild",
					args = { "--minify" },
				},
			},
		})

		vim.api.nvim_create_user_command("Minify", function(args)
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
			print("Minified successfully!")
		end, { range = true })
	end,
}
