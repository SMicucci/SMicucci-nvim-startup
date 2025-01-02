local au = vim.api.nvim_create_autocmd

au('termopen', {
  callback = function ()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
  end,
  desc = 'configure terminal'
})
