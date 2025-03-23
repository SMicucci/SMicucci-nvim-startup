return {
  {
    "xiyaowong/transparent.nvim",
    lazy = true,
    cmd = "TransparentToggle",
    keys = '<leader>tt',
    config = function ()
      local k = require('config.keymap')
      k.nmap('<leader>tt','<cmd>TransparentToggle<CR>','[T]rigger della [T]rasparenza')
    end
  },
}
