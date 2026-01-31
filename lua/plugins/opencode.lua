return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			local k = require("config.keymap")
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			vim.g.opencode_opts = {
				provider = {
					enabled = "terminal",
					terminal = {},
				},
			}

			k.nmap("<leader>cc", function()
				require("opencode").toggle()
			end, "opencode toggle")
			k.tmap("<C-t>", function()
				require("opencode").toggle()
			end, "opencode toggle")

			k.nmap("<leader>ca", function()
				require("opencode").toggle()
			end, "opencode action")
			k.vmap("<leader>ce", function()
				return require("opencode").operator("@this ")
			end, "opencode add range")

			k.nmap("<leader>cu", function()
				require("opencode").command("session.half.page.up")
			end, "opencode half page up")
			k.nmap("<leader>cd", function()
				require("opencode").command("session.half.page.down")
			end, "opencode half page down")
			-- k.tmap("<C-d>", function()
			-- 	require("opencode").command("session.half.page.down")
			-- end, "opencode half page down")
			-- k.tmap("<C-u>", function()
			-- 	require("opencode").command("session.half.page.up")
			-- end, "opencode half page up")
		end,
	},
}
