return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  lazy = false,
  --{{{dependencies
  dependencies = {
    {"nvim-lua/plenary.nvim" },
    {"muniftanjim/nui.nvim" },
    {"nvim-telescope/telescope-dap.nvim" },
  },
  --}}}
  config = function()

    --{{{ # delete action custom function
    local delete_action = function (bufnr)
      local builtin = require'telescope.builtin'
      local actions = require'telescope.actions'
      local state = require'telescope.actions.state'
      local picker = state.get_current_picker(bufnr)
      local selected = state.get_selected_entry()
      local title = picker.prompt_title
      if title == "Buffers" then
        vim.api.nvim_buf_delete(selected.bufnr, {force = false})
        actions.close(bufnr)
        vim.schedule(function()
          builtin.buffers()
        end)
        vim.schedule(function()
          vim.notify(selected.filename .. 'buffer removed\n',vim.log.levels.INFO)
        end)
      elseif title == "Marks" then
        vim.api.nvim_del_mark(selected.ordinal:match('^%S'))
        actions.close(bufnr)
        vim.schedule(function()
          builtin.marks()
        end)
        vim.schedule(function()
          vim.notify('mark \'' .. selected.ordinal:match('^%S') .. '\' removed\n',vim.log.levels.INFO)
        end)
      end
    end
    --}}}

    --{{{ # git picker fallback custom function
    local custom_file_picker = function ()
      local builtin = require'telescope.builtin'
      vim.fn.system('git rev-parse --is-inside-work-tree')
      if vim.v.shell_error == 0 then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end
    --}}}

    --{{{ # setup custom mapping
    local map = {
      i = {
        -- totally avoid normal mode :3
        ['<Esc>'] = "close",
        ['<C-c>'] = "close",
        ['<M-v>'] = "select_vertical",
        ['<C-v>'] = "select_vertical",
        ['<M-s>'] = "select_horizontal",
        ['<C-s>'] = "select_horizontal",
        ['<M-t>'] = "select_tab",
        ['<C-t>'] = "select_tab",
        ['<C-k>'] = "preview_scrolling_up",
        ['<C-j>'] = "preview_scrolling_down",
        ['<C-d>'] = delete_action,
        -- ['<C-q>'] = "<Esc>",
        ['<C-Up>'] = "cycle_history_prev",
        ['<C-Down>'] = "cycle_history_next",
      }
    }
    --}}}

    --{{{ # ignore pattern [vimregex]
    local ignore_patterns = {
      'node_modules',
      'obj',
      'bin',
      '%.git',
      '%.vs',
      'tags',
      '%.vim',
    }
    --}}}

    --{{{ # setup() option here
    local _setup = {
      defaults = {
        path_display = { 'truncate' },
        mappings = map,
        sorting_strategy = 'ascending',
        prompt_prefix = ' ', -- 
        selection_caret = ' ',
      },
      pickers = {
        git_files = { file_ignore_patterns = ignore_patterns },
        live_grep = { file_ignore_patterns = ignore_patterns },
      }
    }
    if vim.fn.executable('rg') then
      _setup.pickers.find_files = { find_command = { "rg", "--files", "--hidden" } }
      for _, dir in ipairs(ignore_patterns) do
        -- ripgrep doesn't require '%' vimgrep escape
        table.insert( _setup.pickers.find_files.find_command, string.format('--glob=!%s', string.gsub(dir, '%%', '') ) )
      end
    end

    require('telescope').setup(_setup)
    --}}}

    -- require extension
    require('telescope').load_extension('dap')

    -- color selection of blue
    vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = '#00BFFF'})

    --{{{ # keymap
    local k = require('config.keymap')
    local builtin = require('telescope.builtin')
    k.nmap('<leader>ff',builtin.find_files, '[f]ind [f]iles')
    k.nmap('<leader>fg',custom_file_picker, '[f]ind [f]iles')
    k.nmap('<leader>fb',builtin.buffers, 'find [b]uffer')
    k.nmap('<leader>fr',builtin.live_grep, '[f]ind g[r]ep')
    k.nmap('<leader>fz',builtin.resume, '[f]ind last action[z]')
    k.nmap('<leader>fm',builtin.marks, '[f]ind [m]arks')
    k.nmap('<leader>fh',builtin.help_tags, '[f]ind [h]elp')
    k.nmap('<leader>fc',builtin.quickfix, '[f]ind qui[c]kfix')
    k.nmap('gd',function() builtin.lsp_definitions({ jump_type = 'tab' }) end,'[g]oto [d]efinition')
    k.nmap('gr',builtin.lsp_references,'[g]oto [R]eference')
    --}}}

  end,
}
