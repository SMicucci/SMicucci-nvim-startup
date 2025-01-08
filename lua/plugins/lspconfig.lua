return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = 'VeryLazy',
    dependencies = {
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
        "williamboman/mason-lspconfig.nvim",
      {
        "Hoffs/omnisharp-extended-lsp.nvim",
        ft = { 'cs', 'cshtml.html' , 'html.cshtml' },
      },
    },
    config = function()
      local masonlsp = require "mason-lspconfig"
      local lspconfig = require "lspconfig"
      local capabilities = require "blink.cmp".get_lsp_capabilities()

      -- list of ensure_installed plugins
      local masonconfig = require "plugins.settings.mason"
      local required = {
        'clangd',
        'css-lsp',
        'html-lsp',
        'json-lsp',
        'lua-language-server',
        'omnisharp',
        -- 'roslyn',
        -- 'rzls',
        'tailwindcss-language-server',
        'typescript-language-server',
      }
      masonconfig.default_install(required)
      masonconfig.auto_update = true
      -- local default_setup = { capabilities = capabilities, }
      -- local setups = {}
      -- setups['roslyn'] = {}

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


      local k = require 'config.keymap'
      local omni_extend = require 'omnisharp_extended'
      local builtin = require 'telescope.builtin'
      local telescope = require 'lazy.core.config'.spec.plugins["telescope.nvim"]
      if telescope and telescope._.loaded then
        k.nmap('gd', function ()
          if vim.opt.filetype:get() == 'cs' or vim.opt.filetype:get() == 'html.cshtml' then
            omni_extend.telescope_lsp_definition()
          else
            builtin.lsp_definitions()
          end
        end,'[g]oto [d]efinition (support C#)')
        k.nmap('gr',function ()
          if vim.opt.filetype:get() == 'cs' or vim.opt.filetype:get() == 'html.cshtml' then
            omni_extend.telescope_lsp_references()
          else
            builtin.lsp_references()
          end
        end,'[g]oto [R]eference')
      end

    end,
  },
}
