local init_msg = [[

	"Se ni' mondo esistesse un po' di bene
	e ognun si considerasse suo fratello
	ci sarebbero meno pensieri e meno pene
	e il mondo ne sarebbe assai più bello."
									P. Pacciani
]]

if vim.g.plugs["chatgpt.nvim"] ~= nil then
	require('chatgpt').setup({
		chat = {
			loading_text = "Caricamento, attendi ...",
			keymaps = {
				close = "<C-c>",
				yank_last = "<C-y>",
				yank_last_code = "<C-k>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
				cycle_modes = "<C-f>",
				next_message = "<C-j>",
				prev_message = "<C-k>",
				select_session = "<Space>",
				rename_session = "r",
				delete_session = "d",
				draft_message = "<C-r>",
				edit_message = "e",
				delete_message = "d",
				toggle_settings = "<C-o>",
				toggle_sessions = "<C-p>",
				toggle_help = "<C-h>",
				toggle_message_role = "<C-r>",
				toggle_system_role_open = "<C-s>",
				stop_generating = "<C-x>",
			},
		},
		openai_params = {
			model = 'gpt-4o-mini',
		},
		openai_edit_params = {
			model = 'gpt-4o-mini',
		},
		actions_path = os.getenv('HOME') .. '/.config/nvim/gpt-actions.json',
	})
end
