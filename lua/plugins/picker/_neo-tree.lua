return {
  'nvim-neo-tree/neo-tree.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function ()
    local k = require'config.keymap'
    k.nmap('<leader>ft','<cmd>Neotree toggle<cr>','[F]ile [T]ree toggle', {silent = true})
  end
}
