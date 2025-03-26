return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
      "mfussenegger/nvim-dap",
  },
  lazy = true,
  keys = {
    "<space>c",
    "<leader>dc",
    "<space>b",
    "<leader>db",
  },
  config = function ()
    local dap = require('dap')
    local dapui = require('dapui')
    local k = require('config.keymap')

    --{{{# setup UI
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 1,
            },
          },
          position = "bottom",
          size = 12,
        },
        {
          elements = {
            {
              id = "breakpoints",
              size = 0.15,
            },
            {
              id = "repl",
              size = 0.85,
            },
          },
          position = "right",
          size = 60,
        },
      },
      ---@diagnostic disable-next-line: missing-fields
      floating = {
        border = "rounded",
      }
    })
    --}}}

    --{{{# attach to dap
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    --}}}

    k.nmap('<leader>dd', dapui.toggle, '[D]ap UI toggle')
    k.nmap('<space>d', dapui.toggle, '[D]ap UI toggle')
  end
}
