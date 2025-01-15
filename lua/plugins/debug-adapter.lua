return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
    },
    lazy = true,
    keys = {
      "<space>c",
      "<leader>dc",
      "<space>b",
      "<leader>db",
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dap.set_log_level('DEBUG')

      --{{{  dapui setup
      ---@diagnostic disable-next-line: missing-fields
      dapui.setup({
        layouts = {
          {
            elements = {
              {
                id = "breakpoint",
                size = 0.15,
              },
              {
                id = "repl",
                size = 0.35,
              },
            },
            position = "left",
            size = 40,
          },
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
        },
        ---@diagnostic disable-next-line: missing-fields
        floating = {
          border = "rounded",
        }
      })
      --}}}

      --{{{  attach ui to standard dap
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

      --	##	setup symbol and colors
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiffDelete', linehl = 'Visual', numhl = 'DiffDelete' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'IncSearch', linehl = 'Visual', numhl =
      'IncSearch' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiffText', linehl = 'DiffChange', numhl = 'DiffText' })

      --{{{ keymap setting
      local k = require('config.keymap')
      k.nmap('<space>c', dap.continue, 'start or [C]ontinue debug')
      k.nmap('<space>n', dap.step_over, 'run [N]ext instruction')
      k.nmap('<space>i', dap.step_into, 'run [I]nto (debug)')
      k.nmap('<space>o', dap.step_out, 'run [O]utro (debug)')
      k.nmap('<space>e', dap.terminate, '[T]erminate debug')
      k.nmap('<space>b', dap.toggle_breakpoint, 'toggle [B]reakpoint (debug)')
      k.nmap('<space>B', dap.clear_breakpoints, 'clear [B]reakpoint (debug)')
      k.nmap('<space>d', dapui.toggle, '[D]ap UI toggle')
      -- duplicate for <leader>d to avoid confusion
      k.nmap('<leader>dc', dap.continue, 'start or [C]ontinue debug')
      k.nmap('<leader>dn', dap.step_over, 'run [N]ext instruction')
      k.nmap('<leader>di', dap.step_into, 'run [I]nto (debug)')
      k.nmap('<leader>do', dap.step_out, 'run [O]utro (debug)')
      k.nmap('<leader>de', dap.terminate, '[T]erminate debug')
      k.nmap('<leader>db', dap.toggle_breakpoint, 'toggle [B]reakpoint (debug)')
      k.nmap('<leader>dB', dap.clear_breakpoints, 'clear [B]reakpoint (debug)')
      k.nmap('<leader>dd', dapui.toggle, '[D]ap UI toggle')
      --}}}

      --	####################
      --		language adapter
      --	####################

      --{{{# check on win32
      local mason_path = vim.fn.stdpath("data") .. '/mason/bin/'
      if vim.g.is_win then
        mason_path = vim.fn.stdpath("data") .. '\\mason\\bin\\'
      end
      --}}}

      --{{{## Bash
      dap.adapters.bashdb = {
        type = 'executable',
        command = mason_path .. 'bash-debug-adapter',
        name = 'bashdb',
      }
      dap.configurations.sh = {
        {
          type = 'bashdb',
          request = 'launch',
          name = "Launch file",
          showDebugOutput = true,
          pathBashdb = mason_path .. 'bashdb',
          pathBashdbLib = mason_path .. '..',
          trace = true,
          file = "${file}",
          program = "${file}",
          cwd = '${workspaceFolder}',
          pathCat = "cat",
          pathBash = "/bin/bash",
          pathMkfifo = "mkfifo",
          pathPkill = "pkill",
          args = {},
          env = {},
          terminalKind = "integrated",
        }
      }
      --}}}

      --{{{##	C/C++/Rust/Zig
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = mason_path .. 'codelldb',
          args = { "--port", "${port}" },
          --detached = false,	-- On windows you may have to uncomment this
        }
      }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c
      dap.configurations.zig = dap.configurations.c
      --}}}

      --{{{##	C#, F#
      local coreclr = mason_path .. 'netcoredbg'
      if vim.g.is_win then coreclr = coreclr .. '.cmd' end
      dap.adapters.coreclr = {
        type = 'executable',
        command = coreclr,
        args = { '--interpreter=vscode', '--server=44305' }
      }
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            local lazy_roslyn = require 'lazy.core.config'.spec.plugins['roslyn.nvim']
            if lazy_roslyn and lazy_roslyn._.loaded then
            -- if false then
              local sln_api = require 'roslyn.sln.api'
              local sln_utils = require 'roslyn.sln.utils'
              local _, sln = sln_utils.predict_target(sln_utils.root(0))

              assert(type(sln) == 'string')
              local projs = sln_api.projects(sln)
              local proj

              --{{{ ### select on multiproject
              if #projs > 1 then
                -- prompt create
                local proj_prompt = ''
                for i, val in ipairs(projs) do
                  local p_name = string.match(val, '([^/\\]+)%.csproj$')
                  proj_prompt = proj_prompt .. '[' .. i .. '] ' .. p_name .. '\n'
                end
                proj_prompt = proj_prompt .. '\nChose the project to run (1 to ' .. #projs .. '): '

                -- project selection
                local p_num = vim.fn.input(proj_prompt)
                proj = projs[tonumber(p_num)]
              else
                proj = projs[1]
              end
              --}}}

              local p_name = string.match(proj, '([^\\/]+)%.csproj$')

              local bins = {}
              local rg_str = vim.fn.system(string.format('rg -u --files | rg -e %s.bin.Debug.*%s.dll', p_name, p_name))
              for p in string.gmatch(rg_str, '([^\n]+)\n') do
                table.insert(bins, p)
              end

              local bin

              --{{{ ### select on multiversion
              if #bins > 1 then
                local bin_prompt = ''
                for i, val in ipairs(bins) do
                  bin_prompt = bin_prompt .. '[' .. i .. '] ' .. val .. '\n'
                end
                bin_prompt = bin_prompt .. '\nChose the library to run (1 to ' .. #bins .. '): '
                local b_num = vim.fn.input(bin_prompt)
                bin = bins[tonumber(b_num)]
              else
                bin = bins[1]
              end
              --}}}

              return vim.fn.fnamemodify(bin, ':p')
            else
              local type = vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
              return type
            end
          end,
        },
      }
      --}}}

      --{{{## Go
      dap.adapters.delve = function(callback, config)
        if config.mode == 'remote' and config.request == 'attach' then
          callback({
            type = 'server',
            host = config.host or '127.0.0.1',
            port = config.port or '38697'
          })
        else
          callback({
            type = 'server',
            port = '${port}',
            executable = {
              command = 'dlv',
              args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
              detached = vim.fn.has("win32") == 0,
            }
          })
        end
      end
      -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
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

      --{{{##	Typescript
      dap.adapters.node = {
        type = "executable",
        command = "bash",
        args = { mason_path .. 'node-debug2-adapter' }
      }
      dap.configurations.typescript = {
        {
          name = "Launch node",
          type = "node",
          request = "launch",
          runtimeArgs = { "--inspect", "-r", "ts-node/register" },
          runtimeExecutable = "node",
          args = { "${file}" },
          --port = 9229,
          cwd = "${workspaceFolder}",
          skipFiles = { "node_modules/**" },
          console = "integratedTerminal",
        },
      }
      --}}}
    end,
  }
}
