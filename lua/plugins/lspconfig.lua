return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = 'VeryLazy',
    --{{{# dependencies
    dependencies = {
      -- "williamboman/mason-lspconfig.nvim",
      --{{{## lua dep
      {
        "folke/lazydev.nvim",
        ft = {'lua'},
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      --}}}
      --{{{## mason
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry"
          }
        }
      },
      --}}}
      --{{{## utilities
      --{{{### preview
      {
        "aznhe21/actions-preview.nvim",
        config = function ()
          local ap = require"actions-preview"
          local aph = require"actions-preview.highlight"
          local key = require "config.keymap"
          ap.setup{
            telescope = {
              sorting_strategy = "ascending",
              layout_strategy = "vertical",
              layout_config = {
                width = 0.8,
                height = 0.9,
                prompt_position = "top",
                preview_cutoff = 20,
                preview_height = function(_, _, max_lines)
                  return max_lines - 15
                end,
              },
            }
          }
          key.nmap("gh", ap.code_actions, "code action UI")
          key.vmap("gh", ap.code_actions, "code action UI")
        end
      },
      --}}}
      --{{{### lens
      {
        "VidocqH/lsp-lens.nvim",
        config = function()
          local lens = require "lsp-lens"
          local key = require "config.keymap"
          lens.setup{
            sections = {
              definition = function (c) return " Def: " .. c end,
              references = function (c) return "󰅪 Ref: " .. c end,
              implements = function (c) return "󰅩 Impl: " .. c end,
            },
          }
          vim.api.nvim_set_hl(0, "LspLens", { link = "Visual", force = true })
      key.nmap("gl", ":LspLensToggle<CR>", "code lens UI")
        end
      },
      --}}}
      --{{{### lsp lines
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      --}}}
      --}}}
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
        'roslyn',
        'rzls',
      }
      --}}}

      lsp_manager.default_install(required)
      lsp_manager.auto_update = true
      lsp_manager.lsp_setup_default { capabilities = capabilities, }
      --{{{## lua_ls setup
      lsp_manager.lsp_setup_custom('lua_ls', {
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
      })
      --}}}

      -- start the setup
      lsp_manager.setup_lsp_server()
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
