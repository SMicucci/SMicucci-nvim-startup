local use_omnisharp = false

return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = 'VeryLazy',
    --{{{dependencies
    dependencies = {
      -- "williamboman/mason-lspconfig.nvim",
      {
        "folke/lazydev.nvim",
        ft = {'lua'},
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry"
          }
        }
      },
      {
        "Hoffs/omnisharp-extended-lsp.nvim",
        ft = { 'cs', 'cshtml.html' , 'html.cshtml' },
        enabled = use_omnisharp,
      },
      {
        "seblj/roslyn.nvim",
        enabled = not use_omnisharp,
      },
      {
        "tris203/rzls.nvim",
        enabled = not use_omnisharp,
      }
    },
    --}}}
    config = function()

      local auto = require 'config.command'
      local autogroup = auto.aug('lspconfig', { clear = true })

      local capabilities = require "blink.cmp".get_lsp_capabilities()

      --{{{ # my lsp "trampoline"
      local lsp_manager = require "plugins.settings.mason"
      --{{{ ## required lsp
      local required = {
        'clangd',
        'css-lsp',
        'html-lsp',
        'json-lsp',
        'lua-language-server',
        'tailwindcss-language-server',
        'typescript-language-server',
      }
      if use_omnisharp then
        table.insert(required,'omnisharp')
      else
        table.insert(required,'roslyn')
        table.insert(required,'rzls')
      end
      --}}}

      lsp_manager.default_install(required)
      lsp_manager.auto_update = true
      local default_setup = { capabilities = capabilities, }
      local setups = {}
      --{{{ ## lua_ls setup
      setups['lua_ls'] = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              }
            }
          })
        end,
        capabilities = capabilities,
        settings = {
          Lua = {}
        },
      }
      --}}}
      --{{{ ## omnisharp setup
      setups["omnisharp"] = {
        cmd = { vim.fs.joinpath( vim.fn.stdpath('data') --[[@as string]],
          'mason/bin/omnisharp'
        )},
        capabilities = capabilities,
      }
      --}}}
      --{{{ ## roslyn setup
      setups["roslyn"] = function ()
        local lazy_roslyn = require 'lazy.core.config'.spec.plugins["roslyn.nvim"]
        local lazy_rzls = require 'lazy.core.config'.spec.plugins["rzls.nvim"]
        if lazy_roslyn and lazy_roslyn._.loaded  then
          -- setup option table
          local opts = {
            exe = {
              'dotnet',
              vim.fs.joinpath(
                vim.fn.stdpath'data'--[[@as string]],
                'mason/packages',
                'roslyn/libexec',
                'Microsoft.CodeAnalysis.LanguageServer.dll'
              )
            },
            args = {
              '--logLevel=Information',
              '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path())
            }
          }
          opts = vim.tbl_deep_extend('keep', opts, { config = default_setup })

          if lazy_rzls and lazy_rzls._.loaded then
            table.insert(opts.args, 
              '--razorSourceGenerator=' .. vim.fs.joinpath(
                vim.fn.stdpath'data' --[[@as string]],
                'mason/packages/',
                'roslyn/libexec',
                'Microsoft.CodeAnalysis.Razor.Compiler.dll'
              )
            )
            table.insert(opts.args,
              '--razorDesignTimePath=' .. vim.fs.joinpath(
                vim.fn.stdpath'data' --[[@as string]],
                'mason/packages/',
                'rzls/libexec/Targets',
                'Microsoft.NET.Sdk.Razor.DesignTime.targets'
              )
            )
            opts.config.handlers = require 'rzls.roslyn_handlers'
          end
          -- vim.notify(vim.inspect(opts)..'\n',vim.log.levels.WARN)
          require'roslyn'.setup(opts)
        end
      end
      --}}}

      -- start the setup
      lsp_manager.setup_lsp_server( default_setup, setups )
      --}}}

      --{{{ mason-lspconfig old setup_handlers
      --[[
      masonlsp.setup_handlers {
        -- default lsp config
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
        -- lua_ls neovim config
        ["lua_ls"] = function ()
          lspconfig.lua_ls.setup {
            on_init = function(client)
              if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                  return
                end
              end

              client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                  version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    "${3rd}/luv/library",
                    "${3rd}/busted/library",
                  }
                }
              })
            end,
            capabilities = capabilities,
            settings = {
              Lua = {}
            },
          }
        end,
        -- omnisharp neovim config
        ["omnisharp"] = function ()
          lspconfig.omnisharp.setup {
            cmd = { vim.fs.joinpath(vim.fn.stdpath('data'), 'mason/bin/omnisharp') },
            capabilities = capabilities,
          }
        end,
      }
      --]]
      --}}}

      --{{{ # omnisharp-extended-lsp implementation (autocmd)
      auto.au('BufEnter', {
        pattern = { '*.cs', '*.cshtml', '*.razor', '*.vb' },
        group = autogroup,
        callback = function ()
          local telescope = require 'lazy.core.config'.spec.plugins["telescope.nvim"]
          local omni = require 'lazy.core.config'.spec.plugins["omnisharp-extended-lsp.nvim"]
          if telescope and telescope._.loaded and omni and omni._.loaded then
            local k = require 'config.keymap'
            local builtin = require 'telescope.builtin'
            local omni_extend = require 'omnisharp_extended'
            k.nmap('gd', function ()
              if vim.opt.filetype:get() == 'cs' or vim.opt.filetype:get() == 'html.cshtml' then
                omni_extend.telescope_lsp_definition()
              else
                builtin.lsp_definitions()
              end
            end,'[g]oto [d]efinition (support omnisharp)')
            k.nmap('gr',function ()
              if vim.opt.filetype:get() == 'cs' or vim.opt.filetype:get() == 'html.cshtml' then
                omni_extend.telescope_lsp_references()
              else
                builtin.lsp_references()
              end
            end,'[g]oto [R]eference (support omnisharp)')
          end
        end,
        once = true,
        desc = 'omnisharp-extended-lsp rewrite on lsp telescope functions'
      })
      --}}}

      --{{{ # inlay_hint trigger
      auto.au({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        group = autogroup,
        pattern = '*',
        callback = function ()
          vim.lsp.inlay_hint.enable()
        end,
        desc = 'trigger inlay hint by default'
      })
      --}}}

    end,
  },
}
