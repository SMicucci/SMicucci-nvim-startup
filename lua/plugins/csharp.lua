--[[

All C# configuration have to stay here
> for this just include stuff to be sure it is included

--]]
return {
  --{{{# Roslyn setup
  {
    "tris203/rzls.nvim",
    dependencies = {
      "seblj/roslyn.nvim",
    },
    ft = {'cs', 'cshtml', 'vb', 'razor'},
    config = function ()
      local lsp_manager = require "plugins.settings.mason"
      local roslyn = require 'roslyn'
      local roslyn_path = vim.fs.joinpath(
        vim.fn.stdpath'data'--[[@as string]],
        'mason', 'packages', 'roslyn')
      local razor_path = vim.fs.joinpath(
        vim.fn.stdpath'data'--[[@as string]],
        'mason', 'packages', 'rzls')
      local opts = {
        exe = {
          'dotnet',
          vim.fs.joinpath( roslyn_path, 'libexec', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
        },
        args = {
          '--logLevel=Information',
          '--extensionLogDirectory='..vim.fs.dirname(vim.lsp.get_log_path()),
          '--stdio',
          '--razorSourceGenerator='..vim.fs.joinpath( roslyn_path, 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
          '--razorDesignTimePath='..vim.fs.joinpath( razor_path, 'libexec', 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets')
        },
        config = {
          handlers = require 'rzls.roslyn_handlers',
        },
        broad_search = true,
      }
      vim.tbl_deep_extend('keep',opts, lsp_manager.get_lsp_default())
      roslyn.setup(opts)
    end
  },
  --}}}
  --{{{# easy-dotnet
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- extra dependencies
      'mfussenegger/nvim-dap',
      {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
          'nvim-tree/nvim-web-devicons',
          'MunifTanjim/nui.nvim',
        }
      },
    },
    config = function ()
      local dotnet = require 'easy-dotnet'
      local dap = require 'dap'
      local tree = require 'neo-tree'
      dotnet.setup{}

      -- neo tree
      tree.setup{
        filesystem = {
          window = {
            mappings = {
              ["R"] = 'easy-dotnet'
            }
          },
          commands = {
            ["easy-dotnet"] = function (state)
              local node = state.tree:get_node()
              local path = node.type == 'directory' and node.path or vim.fs.dirname(node.path)
              dotnet.create_new_item(path, function ()
                require'neo-tree.sources.manager'.refresh(state.name)
              end)
            end
          }
        }
      }

      -- dap
      local debug_dll = nil

      local function ensure_dll()
        if debug_dll == nil then
          debug_dll = dotnet.get_debug_dll()
        end
        return debug_dll
      end

      --{{{## rebuild func
      local function rebuild_project(co, path)
        local spinner = require'easy-dotnet.ui-modules.spinner'.new()
        spinner:start_spinner("Building")
        vim.fn.jobstart(string.format("dotnet build %s", path),{
          on_exit = function (_, res)
            if res == 0 then
              spinner:stop_spinner("Built successfully")
            else
              spinner:stop_spinner("Built failed with exit code "..res, vim.log.levels.ERROR)
              error('Build failed')
            end
            coroutine.resume(co)
          end
        })
        coroutine.yield()
      end
      --}}}

      local cs_dbg = vim.fs.normalize(vim.fs.joinpath( vim.fn.stdpath('data'),
            "mason", "packages", "netcoredbg", "libexec", "netcoredbg", "netcoredbg" ))
      if vim.g.is_win then
        cs_dbg = vim.fs.normalize(vim.fs.joinpath( vim.fn.stdpath('data'),
            "mason", "packages", "netcoredbg", "netcoredbg", "netcoredbg.exe" ))
      end

      dap.adapters.coreclr = {
        type = 'executable',
        command = cs_dbg,
        args = { '--interpreter=vscode' },
      }

      --{{{## configuration
      dap.configurations.cs = {
        {
          type = 'coreclr',
          request = 'launch',
          name = 'launch dll (netcoredbg)',
          program = function ()
            local dll = ensure_dll()
            local co = coroutine.running()
            rebuild_project(co, dll.project_path)
            return dll.relative_dll_path
          end,
          env = function ()
            local dll = ensure_dll()
            local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
            return vars or nil
          end,
          cwd = function ()
            local dll = ensure_dll()
            return dll.relative_project_path
          end
        },
      }
      --}}}

      dap.listeners.before['event_terminated']['easy-dotnet'] = function ()
        debug_dll = nil
      end

    end
  },
  --}}}
}
