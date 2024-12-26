return {
  {
    "tpope/vim-fugitive",
    lazy = true,
    event = 'VeryLazy',
    config = function ()
      local k = require('config.keymap')
      k.nmap('<leader>gf','<cmd>Git<CR><C-W>T','open [G]it [F]ugitive')
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = 'VeryLazy',
    opts = {
      numhl = true,
      current_line_blame_opts = {
        delay = 100,
        virt_text_pos = 'right_align',
      },
      current_line_blame_formatter = '<abbrev_sha>: <author>, <author_time:%x>',
    },
    config = function ()
      local k = require('config.keymap')
      local gs = require('gitsigns')
      k.nmap(
        '<leader>gb',
        function ()
          gs.toggle_current_line_blame()
          gs.toggle_deleted()
          gs.toggle_linehl()
        end,
        'trigger [G]it [B]lame view'
      )
      k.nmap(
        '<leader>gd',
        function ()
          gs.diffthis(nil, {vertical = true})
        end,
        'trigger [G]it(signs) [D]iff'
      )
    end
  }
}
