return {
-- For `plugins/markview.lua` users.
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function ()
      local mv = require "markview"
      local key = require "config.keymap"

      mv.setup {
        preview = {
          filetypes = { 'markdown', 'codecompanion' },
          ignore_buftypes = {},
        },
      }
      key.nmap('<leader>mt', ':Markview Toggle<CR>', '[M]arkivew [T]oggle cmd')
    end
  },
}
