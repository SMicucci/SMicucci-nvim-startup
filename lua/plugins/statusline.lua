return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = true,
		event = "VeryLazy",
		config = function()
			local ll = require("lualine")

			-- codeCompanion integration
			local ai_spinner = require("lualine.component"):extend()

			ai_spinner.processing = false
			ai_spinner.spinner_index = 1

			local spinner_symbols = {
				"⠋",
				"⠙",
				"⠹",
				"⠸",
				"⠼",
				"⠴",
				"⠦",
				"⠧",
				"⠇",
				"⠏",
			}
			local spinner_symbols_len = 10

			-- Initializer
			function ai_spinner:init(options)
				ai_spinner.super.init(self, options)

				local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

				vim.api.nvim_create_autocmd({ "User" }, {
					pattern = "CodeCompanionRequest*",
					group = group,
					callback = function(request)
						if request.match == "CodeCompanionRequestStarted" then
							self.processing = true
						elseif request.match == "CodeCompanionRequestFinished" then
							self.processing = false
						end
					end,
				})
			end

			-- Function that runs every time statusline is updated
			function ai_spinner:update_status()
				if self.processing then
					self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
					return spinner_symbols[self.spinner_index] .. " Thinking... "
				else
					return vim.bo.filetype
				end
			end

			--easy-dotnet indicator
			local job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine, require("opencode").statusline }

			-- setup
			local opts = {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = { "mode", job_indicator },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { ai_spinner },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "progress" },
					lualine_y = { "location" },
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}

			ll.setup(opts)
		end,
	},
}
