if vim.g.plugs["alpha-nvim"] ~= nil then
	local alpha = require('alpha')
	local dashboard = require('alpha.themes.dashboard')

	--	#custom setup
	
local logo = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}


	dashboard.section.header.val = logo

	dashboard.section.buttons.val = {
		dashboard.button("\\ff",	"󰮗  " .. "Fuzzy Finder",			"<cmd> Telescope find_files<CR>"),
		dashboard.button("\\fr",	"󱎸  " .. "Text Finder",			"<cmd> Telescope live_grep<CR>"),
		dashboard.button("\\bb",	"  " .. "File Buffer",			"<cmd> Telescope buffers<CR>"),
		dashboard.button("\\gf",	"  " .. "Git Fugitive",			"<cmd> Git<CR><C-w>o"),
		dashboard.button("\\d",		"  " .. "File Explorer",			"<cmd> Explore<CR>"),
		dashboard.button("\\cc",	"  " .. "ChatGPT prompt",			"<cmd> ChatGPT<CR>"),
		dashboard.button("\\tt",	"󱞟  " .. "Toggle Transparence",	"<cmd> TransparentToggle<CR>"),
	}
	for _, button in ipairs(dashboard.section.buttons.val) do
		button.opts.hl = "String"
		button.opts.hl_shortcut = "Number"
	end

	dashboard.section.footer.val = {
		[[]],
		[[󱐋   Blazingly fast   󱐋]],
		[[ Knoledge is power  ]],
		[[      SMicucci]],
	}

	dashboard.section.header.opts.hl = "Function"
	dashboard.section.buttons.opts.hl = "Tabline"
	dashboard.section.footer.opts.hl = "Keyword"
	dashboard.opts.layout[1].val = 1
	dashboard.opts.layout[3].val = 2
	dashboard.section.terminal.width = 100
	dashboard.section.terminal.height = 9

	--	#default setup
	alpha.setup(dashboard.config)
end
