local ag = require("agentic")
local k = vim.keymap

---pick harness with my preference and ordering
---@return agentic.UserConfig.ProviderName
local function pick_provider()
	if vim.fn.executable("cursor-agent") == 1 then
		return "cursor-acp"
	end
	if vim.fn.executable("claude") == 1 then
		return "claude-agent-acp"
	end
	return "pi-acp"
end

ag.setup({
	provider = pick_provider(),
	acp_providers = {
		["cursor-acp"] = {},
		["claude-agent-acp"] = {},
		["pi-acp"] = {},
	},
	provider_switcher = {
		hide_unhealthy_providers = true,
	},
	slash_commands = { auto_trigger = false },
	file_picker = { auto_trigger = false },
	windows = {
		position = "right",
		width = "30%",
		height = "50%",
	},
	-- iconz
	diagnostic_icons = {
		error = "",
		warn = "",
		info = "",
		hint = " ",
	},
	status_icons = {
		pending = "󰇘",
		in_progress = "󰇘",
		completed = " ",
		failed = " ",
	},
	permission_icons = {
		allow_once = " ",
		allow_always = "󰠜 ",
		reject_once = " ",
		reject_always = "󱂯 ",
	},
	chat_icons = {
		user = " ",
		agent = " ",
	},
	message_icons = {
		thinking = " ",
		finished = " ",
		stopped = "",
		error = " ",
	},
	spinner_chars = {
		generating = { "", "", "", "", "", "" },
		thinking = { " " },
		searching = { " " },
		busy = { "󱊖 " },
	},
})

--- KEYMAP
k.set("n", "<C-\\>", function()
	ag.toggle({ auto_add_to_context = false })
end, { desc = "Toggle Agent" })

k.set({ "v", "n" }, "<C-a>", ag.add_selection_or_file_to_context, { desc = "Add section Agent" })

k.set("n", "<leader>ad", ag.add_current_line_diagnostics, { desc = "line Diagnostic Agent" })
k.set("n", "<leader>aD", ag.add_buffer_diagnostics, { desc = "buffer Diagnostic Agent" })

k.set("n", "<leader>ap", ag.switch_provider, { desc = "switch Provider Agent" })

k.set("n", "<leader>ass", ag.select_session, { desc = "select Session Agent" })
k.set("n", "<leader>asn", ag.new_session, { desc = "New Session Agent" })
k.set("n", "<leader>asd", ag.destroy_session, { desc = "Destroy Session Agent" })
k.set("n", "<leader>as]", ag.next_session, { desc = "Next Session Agent" })
k.set("n", "<leader>as[", ag.prev_session, { desc = "Prev Session Agent" })

k.set("n", "<C-c>", ag.stop_generation, { desc = "stop generation Agent" })

--- COMMANDS

vim.api.nvim_create_user_command("AgentToggle", function()
	ag.toggle({ auto_add_to_context = false })
end, { desc = "toggle Agent" })

vim.api.nvim_create_user_command("AgentSession", ag.select_session, { desc = "select active session" })
vim.api.nvim_create_user_command("AgentResume", ag.restore_session, { desc = "Resume provider session" })
