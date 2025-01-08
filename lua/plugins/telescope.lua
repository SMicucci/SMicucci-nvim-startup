return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  lazy = false,
  -- event = 'VeryLazy',
  dependencies = {
    {"nvim-lua/plenary.nvim" },
    {"muniftanjim/nui.nvim" },
    {"nvim-telescope/telescope-dap.nvim" },
  },
  config = function()

    -- delete action made for some picker
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
          builtin.resume()
        end)
        vim.schedule(function()
          vim.notify(selected.filename .. 'buffer removed',vim.log.levels.INFO)
        end)
      elseif title == "Marks" then
        vim.api.nvim_del_mark(selected.ordinal:match('^%S'))
        actions.close(bufnr)
        vim.schedule(function()
          builtin.resume()
        end)
        vim.schedule(function()
          vim.notify('mark \'' .. selected.ordinal:match('^%S') .. '\' removed',vim.log.levels.INFO)
        end)
      end
    end

    -- git picker with fallback
    local custom_file_picker = function ()
      local builtin = require'telescope.builtin'
      local is_git = vim.fn.system('git rev-parse --is-inside-work-tree')
      if vim.v.shell_error == 0 then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end

    -- setup custom mapping
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
        ['<C-Up>'] = "cycle_history_prev",
        ['<C-Down>'] = "cycle_history_next",
      }
    }

    --	use this string as vimregex
    local ignore_patterns = {
      'node_modules',
      'obj',
      'bin',
      '%.git',
      '%.vs',
      'tags',
      '%.vim',
    }

    -- setup telescope
    require('telescope').setup {
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

    -- require extension
    require('telescope').load_extension('dap')

    -- color selection of blue
    vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = '#00BFFF'})

    -- keymap
    local k = require('config.keymap')
    local builtin = require('telescope.builtin')
    k.nmap('<leader>ff',builtin.find_files, '[f]ind [f]iles')
    k.nmap('<leader>fg',custom_file_picker, '[f]ind [f]iles')
    k.nmap('<leader>fb',builtin.buffers, 'find [b]uffer')
    k.nmap('<leader>fr',builtin.live_grep, '[f]ind g[r]ep')
    k.nmap('<leader>fm',builtin.marks, '[f]ind [m]arks')
    k.nmap('<leader>fh',builtin.help_tags, '[f]ind [h]elp')
    k.nmap('<leader>fc',builtin.quickfix, '[f]ind qui[c]kfix')
    k.nmap('gd',builtin.lsp_definitions,'[g]oto [d]efinition')
    k.nmap('gr',builtin.lsp_references,'[g]oto [R]eference')

  end,
}
