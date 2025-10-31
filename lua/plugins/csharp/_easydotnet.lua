return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		-- lsp dependencies
		"seblyng/roslyn.nvim",
		{ "tris203/rzls.nvim", config = true },
		-- extra dependencies
		"mfussenegger/nvim-dap",
		{
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
			lazy = false,
		},
	},
	ft = { "cs", "cshtml", "vb", "razor" },
	config = function()
		local dotnet = require("easy-dotnet")
		local dap = require("dap")
		local tree = require("neo-tree")
		-- lsp requirements
		local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
		local cmd = {
			"roslyn",
			"--stdio",
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			"--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
			"--razorDesignTimePath="
				.. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
			"--extension",
			vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
		}

		vim.lsp.enable("roslyn", false)

		dotnet.setup({
			lsp = {
				enabled = true,
				roslynator_enabled = true,
				config = {
					cmd = cmd,
					handlers = require("rzls.roslyn_handlers"),
					settings = {
						["csharp|inlay_hints"] = {
							csharp_enable_inlay_hints_for_implicit_object_creation = true,
							csharp_enable_inlay_hints_for_implicit_variable_types = true,

							csharp_enable_inlay_hints_for_lambda_parameter_types = true,
							csharp_enable_inlay_hints_for_types = true,
							dotnet_enable_inlay_hints_for_indexer_parameters = true,
							dotnet_enable_inlay_hints_for_literal_parameters = true,
							dotnet_enable_inlay_hints_for_object_creation_parameters = true,
							dotnet_enable_inlay_hints_for_other_parameters = true,
							dotnet_enable_inlay_hints_for_parameters = true,
							dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
							dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
							dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
						},
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = true,
						},
					},
				},
			},
		})

		--neo-tree setup
		tree.setup({
			filesystem = {
				window = {
					mappings = {
						["R"] = "dotnet new:",
					},
				},
				commands = {
					["dotnet new:"] = function(state)
						local node = state.tree:get_node()
						local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
						dotnet.create_new_item(path, function()
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
				},
			},
		})

		-- dap
		local debug_dll = nil

		local function ensure_dll()
			if debug_dll == nil then
				debug_dll = dotnet.get_debug_dll()
			end
			return debug_dll
		end

		-- rebuild func
		local function rebuild_project(co, path)
			local spinner = require("easy-dotnet.ui-modules.spinner").new()
			spinner:start_spinner("Building")
			vim.fn.jobstart(string.format("dotnet build %s", path), {
				on_exit = function(_, res)
					if res == 0 then
						spinner:stop_spinner("Built successfully")
					else
						spinner:stop_spinner("Built failed with exit code " .. res, vim.log.levels.ERROR)
						error("Build failed")
					end
					coroutine.resume(co)
				end,
			})
			coroutine.yield()
		end

		local cs_dbg = vim.fs.normalize(
			vim.fs.joinpath(
				vim.fn.stdpath("data"),
				"mason",
				"packages",
				"netcoredbg",
				"libexec",
				"netcoredbg",
				"netcoredbg"
			)
		)
		if vim.g.is_win then
			cs_dbg = vim.fs.normalize(
				vim.fs.joinpath(
					vim.fn.stdpath("data"),
					"mason",
					"packages",
					"netcoredbg",
					"netcoredbg",
					"netcoredbg.exe"
				)
			)
		end

		dap.adapters.coreclr = {
			type = "executable",
			command = cs_dbg,
			args = { "--interpreter=vscode" },
		}

		-- configuration
		dap.configurations.cs = {
			{
				type = "coreclr",
				request = "launch",
				name = "launch dll (netcoredbg)",
				program = function()
					local dll = ensure_dll()
					local co = coroutine.running()
					rebuild_project(co, dll.project_path)
					return dll.relative_dll_path
				end,
				env = function()
					local dll = ensure_dll()
					local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
					return vars or nil
				end,
				cwd = function()
					local dll = ensure_dll()
					return dll.relative_project_path
				end,
			},
		}

		dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
			debug_dll = nil
		end
	end,
	init = function()
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})
	end,
}
