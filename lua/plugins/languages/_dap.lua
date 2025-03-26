return {
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

    dap.set_log_level('TRACE')

    --  ##  setup symbol and colors
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiffDelete', linehl = 'Visual', numhl = 'DiffDelete' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'IncSearch', linehl = 'Visual', numhl = 'IncSearch' })
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
    -- k.nmap('<space>d', dapui.toggle, '[D]ap UI toggle') --[[remove to consent dotnet shortcut]]
    -- duplicate for <leader>d to avoid confusion
    k.nmap('<leader>dc', dap.continue, 'start or [C]ontinue debug')
    k.nmap('<leader>dn', dap.step_over, 'run [N]ext instruction')
    k.nmap('<leader>di', dap.step_into, 'run [I]nto (debug)')
    k.nmap('<leader>do', dap.step_out, 'run [O]utro (debug)')
    k.nmap('<leader>de', dap.terminate, '[T]erminate debug')
    k.nmap('<leader>db', dap.toggle_breakpoint, 'toggle [B]reakpoint (debug)')
    k.nmap('<leader>dB', dap.clear_breakpoints, 'clear [B]reakpoint (debug)')
    --}}}

    --  ####################
    --    language adapter
    --  ####################

    --{{{# join mason path
    local function mason_bin(bin_name)
      return vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath('data') --[[@as string]], "mason", "bin", bin_name))
    end
    --}}}

    --{{{## Bash
    dap.adapters.bashdb = {
      type = 'executable',
      command = mason_bin('bash-debug-adapter'),
      name = 'bashdb',
    }
    dap.configurations.sh = {
      {
        type = 'bashdb',
        request = 'launch',
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = mason_bin('bashdb'),
        pathBashdbLib = mason_bin('..'),
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

    --{{{## C/C++/Rust/Zig
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = mason_bin('codelldb'),
        args = { "--port", "${port}" },
        --detached = false, -- On windows you may have to uncomment this
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

    --{{{## Typescript
    dap.adapters.node = {
      type = "executable",
      command = "bash",
      args = { mason_bin('node-debug2-adapter') }
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
