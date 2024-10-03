local init_msg = [[
                                                                 <C-h> per un aiuto
	"Se ni' mondo esistesse un po' di bene
	e ognun si considerasse suo fratello
	ci sarebbero meno pensieri e meno pene
	e il mondo ne sarebbe assai più bello."
									P. Pacciani
]]

local custom_action_path = os.getenv('HOME') .. '/.config/nvim/gpt-actions.json'

print('lua/plugin/chatgpt.com => ' .. custom_action_path)

if vim.g.plugs["chatgpt.nvim"] ~= nil then
	require('chatgpt').setup({
		chat = {
			welcome_message = init_msg,
			loading_text = "Caricamento, attendi ...",
		},
		openai_params = {
			model = 'gpt-4o-mini',
		},
		openai_edit_params = {
			model = 'gpt-4o-mini',
		},
		actions_path = custom_action_path,
	})
end
