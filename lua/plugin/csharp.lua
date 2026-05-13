local csharp_group = vim.api.nvim_create_augroup("c_sharp_plugs", { clear = true })

local initialized = false

-- function to setup roslyn and easy-dotnet (dap included)
local function setup_csharp()
	if initialized then
		return
	end
	initialized = true

	local function get_debugger_path()
		local path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "netcoredbg")
		if vim.g.is_win then
			path = path .. ".cmd"
		end
		return path
	end

	require("easy-dotnet").setup({
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

	require("roslyn").setup({
		config = {
			settings = {
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "fullSolution",
					dotnet_compiler_diagnostics_scope = "fullSolution",
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
					dotnet_enable_test_code_lens = false,
				},
				["csharp|completion"] = {
					dotnet_provide_regex_completions = true,
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
				},
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
				["csharp|symbol_search"] = {
					dotnet_search_reference_assemblies = true,
				},
				["csharp|formatting"] = {
					dotnet_organize_imports_on_format = true,
				},
			},
		},
	})
end

-- initialize if filetype is correct
vim.api.nvim_create_autocmd("FileType", {
	group = csharp_group,
	once = true,
	pattern = { "cs", "vb", "razor", "cshtml" },
	callback = function()
		setup_csharp()
	end,
})

-- initialize if solution is present here or in upped directory
vim.api.nvim_create_autocmd("BufEnter", {
	group = csharp_group,
	once = true,
	callback = function()
		local sln = vim.fs.find(function(name)
			return name:match("%.sln$")
		end, { upward = true, type = "file" })
		if #sln > 0 then
			setup_csharp()
		end
	end,
})
