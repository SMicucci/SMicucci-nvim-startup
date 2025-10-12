return {
	"mhartington/formatter.nvim",
	config = function()
		-- Utilities for creating configurations
		local util = require("formatter.util")
		local auto = require("config.command")

		local format_group = auto.aug("format", { clear = true })

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
					function()
						if util.get_current_buffer_file_name() == "special.lua" then
							return nil
						end
						return {
							exe = "stylua",
							args = {
								"--search-parent-directories",
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--",
								"-",
							},
							stdin = true,
						}
					end,
				},
				-- cpp = {
				-- 	function()
				-- 		return {
				-- 			exe = "clang-format",
				-- 			args = {
				-- 				"-assume-filename",
				-- 				require("formatter.util").escape_path(
				-- 					require("formatter.util").get_current_buffer_file_name()
				-- 				),
				-- 				"-style='{BasedOnStyle: llvm, IndentWidth: 8, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: true, ColumnLimit: 80}'",
				-- 			},
				-- 			stdin = true,
				-- 		}
				-- 	end,
				-- },
				c = {
					function()
						return {
							exe = "clang-format",
							args = {
								"-assume-filename",
								require("formatter.util").escape_path(
									require("formatter.util").get_current_buffer_file_name()
								),
								"-style='{BasedOnStyle: llvm, IndentWidth: 8, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: true, ColumnLimit: 100}'",
							},
							stdin = true,
						}
					end,
				},
				javascript = {
					function()
						return {
							exe = "prettier",
							args = {
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--tab-width",
								"2",
								"--semi",
								"true",
								"--single-quote",
								"false",
								"--print-width",
								"100",
							},
							stdin = true,
						}
					end,
				},
				typescript = {
					function()
						return {
							exe = "prettier",
							args = {
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--tab-width",
								"2",
								"--semi",
								"true",
								"--single-quote",
								"false",
								"--print-width",
								"100",
							},
							stdin = true,
						}
					end,
				},
				["*"] = {
					function()
						if vim.bo.filetype ~= "markdown" then
							require("formatter.filetypes.any").remove_trailing_whitespace()
						end
					end,
				},
			},
		})

		auto.au("BufWritePost", {
			pattern = "*",
			group = format_group,
			command = "FormatWriteLock",
			desc = "default auto format by default",
		})
	end,
}
