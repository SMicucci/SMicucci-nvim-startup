return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_line = {
        only_current_line = true,
        highlight_whole_line = false,
      },
    })
  end,
}
