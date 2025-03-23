return {
  'aznhe21/actions-preview.nvim',
  config = function ()
    local ap = require"actions-preview"
    -- local aph = require"actions-preview.highlight"
    local k = require "config.keymap"
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
    k.nmap("gh", ap.code_actions, "code action UI")
    k.vmap("gh", ap.code_actions, "code action UI")
  end
}
