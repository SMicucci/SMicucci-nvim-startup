if vim.g.plugs["chatgpt.nvim"] ~= nil then
	require('chatgpt').setup({
		openai_params = {
			model = 'gpt-4o-mini',
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 2048,
			temperature = 0.2,
			top_p = 0.1,
			n = 1,
		}
	})
end
