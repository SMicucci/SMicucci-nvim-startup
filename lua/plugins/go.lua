return {
  {
    'https://github.com/ray-x/go.nvim',
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup()
      local dap = require 'dap'

      local k = require 'config.keymap'
      local auto = require 'config.command'

      k.nmap('<space>go', '<cmd>GoPkgOutline<cr>','toggle project package and API', {silent = true})

      local go_group = auto.aug('GoFormat', {})

      auto.au('BufWritePre', {
        pattern = '*.go',
        group = go_group,
        callback = function ()
          require'go.format'.goimports()
        end,
        desc = 'Go auto import and format before write'
      })

      --{{{# DAP
      dap.adapters.delve = function (cb)
        cb({
          type = 'server',
          port = '38967',
          executable = {
            command = 'dvl',
            args = { 'dap', '-l', '127.0.0.1:38967', '--log', '--log-output=dap' },
            detatched = vim.g.is_win == nil,
          }
        })
      end

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}"
        },
        -- works with go.mod packages and sub packages 
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        }
      }
      --}}}

    end,
  }
}
