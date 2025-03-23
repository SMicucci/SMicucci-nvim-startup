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
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.35,
          }
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
      adapters = {
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
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "gpt-4o-mini",
              }
            }
          })
        end
      },
      strategies = {
        chat = {
          adapter = "openai",
        },
        inline = {
          adapter = "openai",
        }
      },
    }

    key.nmap("<leader>cc",cc.chat, "[C]ode[C]ompanion chat open")
    key.nmap("<leader>ct",cc.toggle, "[C]odeCompanion [T]oggle")
    key.vmap("<leader>ca", ":CodeCompanionActions", "Trigger [C]ode [A]ction based on selection")

  end
}
