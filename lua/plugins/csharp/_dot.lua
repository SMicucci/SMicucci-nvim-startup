return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"nvim-neo-tree/neo-tree.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	ft = { "cs", "razor", "vb", "cshtml" },
	config = function()
		local dot = require("easy-dotnet")
		local tree = require("neo-tree")

		local function get_debugger_path()
			local path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "netcoredbg")
			if vim.g.is_win then
				path = path .. ".cmd"
			end
			return path
		end

		dot.setup({
			lsp = {
				enabled = false,
				roslynator_enabled = false,
			},
			debugger = {
				enabled = true,
				bin_path = get_debugger_path(),
			},
			diagnostics = {
				default_severity = "warning",
				setqflist = true,
				auto_open = true,
			},
		})

		tree.setup({
			filesystem = {
				window = {
					mappings = {
						["R"] = "dot",
					},
				},
				commands = {
					["dot"] = function(state)
						local node = state.tree:get_node()
						local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
						dot.create_new_item(path, function()
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
				},
			},
		})
	end,
}
