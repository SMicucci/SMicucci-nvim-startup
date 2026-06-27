local k = vim.keymap

k.set("n", "d", "<C-d>", { buffer = true, desc = "man page navigation" })
k.set("n", "u", "<C-u>", { buffer = true, desc = "man page navigation" })
k.set("n", "j", "<C-e>", { buffer = true, desc = "man page navigation" })
k.set("n", "k", "<C-y>", { buffer = true, desc = "man page navigation" })
k.set("n", "<C-j>", "j", { buffer = true, desc = "man page navigation" })
k.set("n", "<C-k>", "k", { buffer = true, desc = "man page navigation" })
