return {
	"mhartington/formatter.nvim",
	config = function()
		-- Utilities for creating configurations
		local util = require("formatter.util")
		local auto = require("config.command")

		local format_group = auto.aug("format", { clear = true })
		local clang_format = {
			exe = "clang-format",
			args = {
				"-assume-filename",
				util.escape_path(util.get_current_buffer_file_name()),
				"--style='file:" .. vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), ".clang-format")) .. "'",
			},
			stdin = true,
		}

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
				cpp = {
					function()
						return clang_format
					end,
				},
				c = {
					function()
						return clang_format
					end,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
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
