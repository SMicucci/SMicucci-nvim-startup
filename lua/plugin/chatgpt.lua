local init_msg = [[
                                                                             <C-h> per altre info
	"Se ni' mondo esistesse un po' di bene
	e ognun si considerasse suo fratello
	ci sarebbero meno pensieri e meno pene
	e il mondo ne sarebbe assai più bello."
									P. Pacciani
]]

if vim.g.plugs["chatgpt.nvim"] ~= nil then
	--	##	set link to actions		--i didn't like the 3.5 function, too expensive
	local src = vim.fs.normalize('~/.config/nvim/actions.json')
	local dest = vim.fs.normalize('~/.local/share/nvim/plugged/chatgpt.nvim/lua/chatgpt/flows/actions/actions.json')
	if (vim.uv.fs_stat(dest) == nil) then
		vim.uv.fs_link(src,dest)
	elseif (vim.uv.fs_stat(src).ino ~= vim.uv.fs_stat(dest).ino) then
		vim.uv.fs_unlink(dest)
		vim.uv.fs_link(src,dest)
	end

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
			model = 'gpt-4o-mini',
			max_tokens = 500,
		},
		openai_edit_params = {
			model = 'gpt-4o-mini',
		},
		predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/SMicucci/SMicucci-nvim-startup/refs/heads/master/prompts.csv",
		highlights = {
			params_value = "Character",
			active_session = "Conditional",
		},
	})
end
