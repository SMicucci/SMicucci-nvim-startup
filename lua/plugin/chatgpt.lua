local init_msg = [[
                                                                             <C-h> per altre info
	"Se ni' mondo esistesse un po' di bene
	e ognun si considerasse suo fratello
	ci sarebbero meno pensieri e meno pene
	e il mondo ne sarebbe assai più bello."
									P. Pacciani
]]

if vim.g.plugs["chatgpt.nvim"] ~= nil then
	--	##	setup
	require('chatgpt').setup({
		edit_with_instructions = {
			keymaps = {
				close = {"<C-c>", "<Leader>q"},
			},
		},
		chat = {
			welcome_message = init_msg,
			loading_text = "Caricamento, attendi ...",
			sessions_window = {
				active_sign = " 󰄯  ",
				inactive_sign = " 󰄰  ",
				current_line_sign = "",
			},
			keymaps = {
				close = {"<C-c>", "<Leader>q"},
			},
		},
		popup_layout = {
			default = "center",
			center = {
				width = "90%",
				height = "90%",
			},
			right = {
				width = "40%",
				width_settings_open = "50%",
			},
		},
		openai_params = {
			model = "gpt-4o-mini",
			max_tokens = 500,
		},
		openai_edit_params = {
			model = "gpt-4o-mini",
		},
		predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/SMicucci/SMicucci-nvim-startup/refs/heads/master/prompts.csv",
		highlights = {
			params_value = "Character",
			active_session = "Conditional",
		},
		ignore_default_actions_path = true,
		actions_paths = { "~/.config/nvim/actions.json" }
	})
end
