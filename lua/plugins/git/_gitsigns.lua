return {
  "lewis6991/gitsigns.nvim",
  event = 'BufRead',
  config = function ()
    local gs = require'gitsigns'
    local k = require'config.keymap'
    gs.setup{
      numhl = true,
      signcolumn = false,
      current_line_blame_formatter = '<abbrev_sha> (<author>) <author_time:%d %b %y>',
      current_line_blame_opts = {
        virt_text_pos = 'right_align',
        delay = 250,
      }
    }
    k.nmap('<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', 'git sign blame-mode')
  end
}
