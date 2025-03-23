return {
  "windwp/nvim-autopairs",
  opts = function ()
    local pairs = require 'nvim-autopairs'
    local rule = require 'nvim-autopairs.rule'
    local conds = require 'nvim-autopairs.conds'
    pairs.setup{
      check_ts = true,
      ts_config = {
        lua = {'string'},
        javascipt = {'template_string'},
        java = false,
      }
    }
    -- # autopairs setup
    --	add same rule for '<>'
    pairs.add_rule(
      rule('<', '>', {
        '-html',
        '-javascriptreact',
        '-typescriptreact',
      }):with_pair(
          conds.before_regex('%a+:?:?$', 3)
        )
        :with_move(function(opts)
        return opts.char =='>'
      end))
  end
}
