require("markview").setup({ preview = { filetype = { "markdown", "AgenticChat" }, ignore_buftypes = {} } })
vim.keymap.set("n", "<leader>mt", "<cmd>Markview Toggle<CR>", { desc = "markview toggle" })
