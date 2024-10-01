--	github copilot setting
if vim.g.plugs["copilot.lua"] ~= nil or vim.g.plugs["copilot-cmp"] ~= nil then
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			["*"] = false
		}
	})
end

--	openai API setting
if vim.g.plugs["cmp-ai"] ~= nil then
	local cmp_ai = require('cmp_ai.config')

	cmp_ai:setup({
		max_lines = 1000,
		provider = 'OpenAI',
		provider_options = {
			model = 'gpt-4o-mini',
		},
		notify = true,
		notify_callback = function (msg)
			vim.notify(msg)
		end,
		ignored_file_types = {
			["*"] = true,
		}
	})
end
