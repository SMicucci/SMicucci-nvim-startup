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
        opts = {}
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { 'lua_ls', 'clangd', 'omnisharp' },
          automatic_installed = true,
        }
      },
      {
        "Hoffs/omnisharp-extended-lsp.nvim",
        ft = { 'cs', 'html.cshtml' },
      },
    },
    config = function()
      local mason = require"mason-lspconfig"
      local lspconf = require"lspconfig"
      local capabilities = require"blink.cmp".get_lsp_capabilities()

      mason.setup_handlers {
        -- default lsp config
        function(server_name)
          lspconf[server_name].setup {
            capabilities = capabilities,
          }
        end,
        -- lua_ls neovim config
        lspconf.lua_ls.setup {
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
        },
        -- omnisharp neovim config
        lspconf.omnisharp.setup {
          capabilities = capabilities,
          cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/omnisharp') }
        },
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
        k.nmap('gR',function ()
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
