return {
  "folke/lazydev.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  ft = {'lua'},
  config = function ()
    local ld = require 'lazydev'
    local mauto = require 'mason-automation'
    ld.setup({
      library = {
        {
          path = "${3rd}/luv/library",
          words = {
            "vim%.uv"
          }
        },
      },
    })

    mauto.install('lua_ls')

    mauto.lsp_set_custom('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          ---@diagnostic disable-next-line
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
      -- capabilities = capabilities,
      settings = {
        Lua = {}
      },
    })

  end ,
}
