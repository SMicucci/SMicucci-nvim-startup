return {
  "https://github.com/leoluz/nvim-dap-go",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  config = function ()
    local dapgo = require 'dap-go'
    dapgo.setup()
  end
}
