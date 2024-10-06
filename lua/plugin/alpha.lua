if vim.g.plugs["alpha-nvim"] ~= nil then
	local alpha = require('alpha')
	local dashboard = require('alpha.themes.dashboard')

	--	#custom setup
	dashboard.section.header.val = {
		[[          #                              #]],
		[[        #####                            # #]],
		[[      #########                          #   #]],
		[[    #############                        #     #]],
		[[  # ###############                      #       #]],
		[[#   #################                    #         #                                 #####]],
		[[#     ################                   #         #                               #######]],
		[[#       ################                 #         #                               #######]],
		[[#         ################               #         #                                 #####]],
		[[#           ################             #         #   ##########     ###########       ##     ###########]],
		[[#         #  ################            #         #     #     #        #######    ###           #     #    #####          #####]],
		[[#         #    ################          #         #     #     #       #######     #  ###        #     #  #########      #########]],
		[[#         #      ################        #         #     #     #      #######      #     #       #     # ############  #############]],
		[[#         #        ################      #         #     #     #     #######       #     #       #     # ####  #######  #####  ######]],
		[[#         #          ################    #         #     #     #    #######        #     #       #     # ###     ######  ##      #####]],
		[[#         #            ################  #         #     #     #   #######         #     #       #     # #         #####          #####]],
		[[#         #              ################          #     #     #  #######          #    ##       #     #            ####           ####]],
		[[#         #                ################        #     #     # #######           #    ##       #     #            ####           ####]],
		[[#         #                  ################      #     #      #######            #    ##       #     #            ####           ####]],
		[[#         #                    ################    #     #     #######             #    ##       #     #            ####           ####]],
		[[#         #                      ################  #     #    #######              #   ###       #     #            ####           ####]],
		[[  #       #                        ################      #   #######               #   ###       #     #            ####           ####]],
		[[    #     #                          #############       #  #######                #   ###       #     #            ####           ####]],
		[[      #   #                            #########         # #######                 #   ###       #     #            ####           ####]],
		[[        # #                              #####           ########                  #  ####       #     #            ####           ####]],
		[[          #                                #             #######                 ###########   ###########        ########       ########]],
	}
	dashboard.section.buttons.val = {
		dashboard.button("\\ff",	"󰱼   " .. "Fuzzy Finder",			"<cmd> Telescope find_files<CR>"),
		dashboard.button("\\fr",	"󱎸   " .. "Text Finder",			"<cmd> Telescope live_grep<CR>"),
		dashboard.button("\\bb",	"   " .. "File Buffer",			"<cmd> Telescope buffers<CR>"),
		dashboard.button("\\gf",	"   " .. "Git Fugitive",			"<cmd> Git<CR><C-w>o"),
		dashboard.button("\\d",		"   " .. "File Explorer",			"<cmd> Explore<CR>"),
		dashboard.button("\\cc",	"   " .. "ChatGPT prompt",			"<cmd> ChatGPT<CR>"),
		dashboard.button("\\tt",	"󱞟   " .. "Toggle Transparence",	"<cmd> TransparentToggle<CR>"),
	}
	for _, button in ipairs(dashboard.section.buttons.val) do
		button.opts.hl = "Keyword"
		button.opts.hl_shortcut = "Number"
	end
	dashboard.section.header.opts.hl = "Function"
	dashboard.section.buttons.opts.hl = "String"
	dashboard.section.footer.opts.hl = "Statement"
	dashboard.opts.layout[1].val = 4

	--	#default setup
	alpha.setup(dashboard.config)
end
