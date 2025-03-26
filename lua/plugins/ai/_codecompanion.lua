return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local cc = require "codecompanion"
    local key = require "config.keymap"

    cc.setup {
      --{{{# display
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.40,
          },
          show_settings = false,
          start_in_insert_mode = true,
        },
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ",
          provider = "telescope", -- default|telescope
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          }
        },
      },
      --}}}
      --{{{# strategies
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        }
      },
      --}}}
      --{{{# adapters
      adapters = {
        opts = {
          show_defaults = false,
        },
        --{{{## ollama
        deepseek = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "deepseek-r1",
            schema = {
              model = {
                default = "deepseek-r1:14b",
              },
            },
          })
        end,
        --}}}
        --{{{## openai
        openai = function()
          ---@type CodeCompanion.Adapter
          ---@diagnostic disable-next-line: missing-fields
          local openai_opts = {
            schema = {
              model = {
                default = "o3-mini",
                choices = {
                  ["o3-mini"] = { opts = { can_reason = true } },
                  "gpt-4o-mini",
                },
              },
            },
          }
          return require("codecompanion.adapters").extend("openai", openai_opts)
        end
        --}}}
      },
      --}}}
      opts = {
        language = "Italiano",
      }
    }

    --{{{# keymap
    key.nmap("<leader>cc",cc.chat, "[C]ode[C]ompanion chat open")
    key.nmap("<leader>ct",cc.toggle, "[C]odeCompanion [T]oggle")
    key.nmap("<leader>ca", "<cmd>CodeCompanionActions<cr>", "Select AI actions", {silent = true})
    key.vmap("<leader>ca", "<cmd>CodeCompanionActions<cr>", "Select AI actions", {silent = true})
    key.vmap("ga", "<cmd>CodeCompanionChat Add<cr>", "Add visual to chat", {silent = true})
    --}}}

  end
}
