require("markview").setup({ preview = { filetype = { "markdown" }, ignore_buftypes = {} } })
vim.keymap.set("n", "<leader>mt", "<cmd>Markview Toggle<CR>", { desc = "markview toggle" })
