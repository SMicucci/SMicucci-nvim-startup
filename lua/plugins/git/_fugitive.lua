return {
  "tpope/vim-fugitive",
  event = 'VeryLazy',
  config = function ()
    local k = require'config.keymap'
    k.nmap('<leader>gf', '<cmd>Git<cr><c-w>T', 'open fugitive')
    k.nmap('<leader>gd', '<cmd>Gvdiffsplit<cr>', 'fugitive split')
  end
}
