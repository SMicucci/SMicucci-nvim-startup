local snacks = require("snacks")
local ap = require("actions-preview")
local k = vim.keymap

snacks.setup({
	-- dashboard configuration
	dashboard = {
		preset = {
			pick = nil,
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = "<leader>ff" },
				{ icon = " ", key = "r", desc = "Grep File", action = "<leader>fr" },
				{ icon = " ", key = "g", desc = "Git Branches", action = "<leader>fgb" },
				{ icon = " ", key = "o", desc = "Old Files", action = "<leader>fo" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			header = [[
   ⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄                                        
   ⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄          ⣿⣿⣷⡁⢆⠈⠕⢕⢂⢕⢂⢕⢂⢔⢂⢕⢄⠂⣂⠂⠆⢂⢕⢂⢕⢂⢕⢂⢕⢂
  ⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄          ⣿⣿⣿⡷⠊⡢⡹⣦⡑⢂⢕⢂⢕⢂⢕⢂⠕⠔⠌⠝⠛⠶⠶⢶⣦⣄⢂⢕⢂⢕
  ⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄          ⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂
 ⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰          ⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂
 ⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤          ⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔
⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗          ⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿
⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟           ⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿
⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃           ⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃
⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃           ⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈
 ⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃            ⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈
  ⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁             ⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈
    ⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁               ⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈
       ⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁     ⢀⣠⣴          ⠨⡂⡀⢑⢕⡅⠂⠄⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢔⢕⢕⣿⣿⠠⠈
⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿                                        
            ]],
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			-- { section = "keys", gap = 1, padding = 1 },
		},
	},
	-- picker configuration
	picker = {
		enabled = true,
		actions = {
			vsplit = function(picker, item)
				picker:close()
				if item then
					vim.cmd("vsplit " .. item.file)
				end
			end,
			hsplit = function(picker, item)
				picker:close()
				if item then
					vim.cmd("split " .. item.file)
				end
			end,
		},
		win = {
			input = {
				keys = {
					["<m-v>"] = { "vsplit", mode = { "i", "n" } },
					["<m-s>"] = { "hsplit", mode = { "i", "n" } },
				},
			},
		},
		-- easy-dotnet explorer implementation
		sources = {
			explorer = {
				win = {
					list = {
						keys = {
							["<c-r>"] = "explorer_add_dotnet",
						},
					},
				},
				actions = {
					explorer_add_dotnet = function(picker)
						local dir = picker:dir()
						local dot = require("easy-dotnet")
						dot.create_new_item(dir, function(item_path)
							local tree = require("snacks.explorer.tree")
							local actions = require("snacks.explorer.actions")
							tree:open(dir)
							tree:refresh(dir)
							actions.update(picker, { target = item_path })
							picker:focus()
						end)
					end,
				},
			},
		},
	},
	quickfile = { enabled = true },
	notifier = { enabled = true },
	input = { enabled = true },
	-- words = { enabled = true },
	terminal = {
		win = {
			position = "float",
			width = 0.9,
			height = 0.9,
			border = "rounded",
		},
	},
})

ap.setup({
	backend = { "snacks" },
	diff = { ctxlen = 5 },
	snacks = { layout = { preset = "vertical" } },
})

-- explorer
k.set("n", "<leader>e", Snacks.explorer.open, { desc = "explorer picker" })
-- basic pickers
k.set("n", "<leader>ff", Snacks.picker.files, { desc = "file picker" })
k.set("n", "<leader>fr", Snacks.picker.grep, { desc = "grep picker" })
k.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "buffer picker" })
k.set("n", "<leader>fh", Snacks.picker.help, { desc = "help picker" })
k.set("n", "<leader>fm", Snacks.picker.man, { desc = "man picker" })
k.set("n", "<leader>fq", Snacks.picker.qflist, { desc = "quickfix picker" })
k.set("n", "<leader>fd", Snacks.picker.diagnostics, { desc = "diagnostics picker" })
k.set("n", "<leader>fk", Snacks.picker.keymaps, { desc = "keymap picker" })
k.set("n", "<leader>fz", Snacks.picker.resume, { desc = "resume picker" })
-- git pickers
k.set("n", "<leader>fgb", Snacks.picker.git_branches, { desc = "git branch picker" })
k.set("n", "<leader>fgd", Snacks.picker.git_diff, { desc = "git branch picker" })
k.set("n", "<leader>fgl", Snacks.picker.git_log, { desc = "git branch picker" })
k.set("n", "<leader>fgf", Snacks.picker.git_files, { desc = "git file picker" })
-- lsp pickers
k.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "lsp definition" })
k.set("n", "gD", Snacks.picker.lsp_declarations, { desc = "lsp declaration" })
k.set("n", "gr", Snacks.picker.lsp_references, { desc = "lsp reference" })
k.set("n", "gi", Snacks.picker.lsp_implementations, { desc = "lsp implementation" })
k.set("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "lsp type implementation" })
k.set({ "v", "n" }, "gh", ap.code_actions, { desc = "code action picker" })

-- toggle terminal
k.set("n", "<c-/>", Snacks.terminal.toggle, { desc = "toggle terminal" })
