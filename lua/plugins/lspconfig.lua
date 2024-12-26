return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    ft = {
      "bash",
      "c",
      "cpp",
      "docker",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "typescript"
    },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = {"lua"},
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
          ensure_installed = { 'lua_ls', 'clangd' },
          automatic_installed = true,
        }
      },
    },
    config = function()
      require"mason-lspconfig".setup_handlers {
        -- default lsp config
        function(server_name)
          require"lspconfig"[server_name].setup {}
        end,
        -- lua_ls neovim config
        require'lspconfig'.lua_ls.setup {
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
          settings = {
            Lua = {}
          }
        }
      }
    end,
  },
}
