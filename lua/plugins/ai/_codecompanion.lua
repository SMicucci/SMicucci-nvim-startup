return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local cc = require "codecompanion"
    local key = require "config.keymap"

    --{{{# read env
    local function get_var(api_name)
      if vim.g.is_win then
        print( 'OPENAI_API_KEY => ' .. vim.fn.trim(vim.fn.system('powershell -Command "$env:'..api_name..'"')) )
        return vim.fn.trim(vim.fn.system('powershell -Command "$env:'..api_name..'"'))
      else
        vim.cmd("cmd: echo $"..api_name)
        return vim.fn.trim(vim.fn.system("cmd: echo $"..api_name))
      end
    end
    --}}}

    cc.setup {
      --{{{# display
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.30,
          },
        },
        action_palette = {
          width = 75,
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
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = get_var("OPENAI_API_KEY")
            },
            schema = {
              model = {
                default = "gpt-4o-mini",
                choices = {
                  ["o3-mini"] = { opts = { can_reason = true } },
                  "gpt-4o-mini",
                },
              },
            },
          })
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
