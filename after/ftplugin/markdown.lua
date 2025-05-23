local set = vim.opt_local
local auto = require 'config.command'
local keymap = require 'config.keymap'

local markdown = auto.aug('markdown', { clear = true })

set.number = false

local md_aucmd = function (e, cb, desc)
  assert(type(e) == 'string' or type(e) == 'table', 'e must be a string or table')
  assert(type(cb) == 'function', 'cb must be a function')
  auto.au(e, {
    pattern = '*.md',
    group = markdown,
    callback = cb,
    desc = desc,
  })
end

-- override html every time file is writtem 
-- create html each time is loaded
md_aucmd(
  { 'BufWritePost', 'BufAdd' },
  function()
    local name = string.gsub(vim.fn.bufname(), '%.md$', '')
    if name:match(vim.fn.stdpath('data')--[[@as string]]) then
      return
    end
    if vim.fn.executable('pandoc') then
      local cmd = "pandoc";
      if vim.g.is_win then
        cmd = cmd .. '.exe'
      end
      local css = vim.fs.joinpath(vim.fn.stdpath('config')--[[@as string]], 'gfm.css')
      cmd = string.format('!%s --from=gfm --to=html -o %s.html %s.md --css=%s --standalone', cmd, name, name, css)
      vim.fn.execute(cmd)
      -- vim.notify('updated '..name..'.hmtl with pandoc!',vim.log.levels.INFO)
      return
    else
      vim.notify(
        string.format('to support real time view of %s.md install `$ pandoc`', vim.fn.bufname()),
        vim.log.levels.WARN)
    end
    if vim.fn.executable('markdown') then
      local cmd = string.format('!markdown %s.md > %s.html', name, name)
      vim.fn.execute(cmd)
      -- vim.notify('updated '..name..'.hmtl with markdown!',vim.log.levels.INFO)
      return
      -- TODO: check how to launch default browser page
    else
      vim.notify(
        string.format('to support real time view of %s.md at least install `$ markdown`', vim.fn.bufname()),
        vim.log.levels.ERROR)
    end
  end,
  'Markdown create temporary html render'
)

-- delete html each time buffer is deleted
-- delete html each time buffer is hidden (avoid renaming from other type of event)
md_aucmd(
  { 'BufDelete', 'BufHidden' },
  function()
    local md_name = string.gsub(vim.fn.bufname(), '%.md$', '')
    if md_name:match(vim.fn.stdpath('data')--[[@as string]]) then
      return
    end
    local name = string.gsub(vim.fn.bufname(), '%.md$', '.html')
    if vim.fn.delete(name) == -1 then
      vim.notify(string.format('temporary file \'%s\' not deleted!\n', name), vim.log.levels.ERROR)
    end
  end,
  'Markdown delete temporary html render'
)


auto.cmd(
  'Index',
  function ()
    local titles = {}
    local idx

    -- save all titles and check for index
    for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)) do
      if line:match('^##?#?#?#?#? ') then
        table.insert(titles, { row = i, value = line })
        if not idx and line:match('^# Index') then
          idx = #titles
        end
      end
    end

    -- parse title to link
    local get_index_line = function(title_string)
      assert(type(title_string) == 'string', 'get_index_line argument invalid (not a string)')
      local name = string.gsub(title_string, '^##?#?#?#?#? ', '', 1)
      local link = string.lower(string.gsub(title_string, '#* ', function(s)
        local c = ''
        if s == ' ' then c = '-' else c = '#' end
        return c
      end))
      local h_num = #string.match(title_string, '#*')
      local h_syms = string.match(title_string, '#*')
      local tabs = string.gsub(string.gsub(h_syms, '#', '    ', h_num - 1), '#', '')
      return string.format('%s - [%s](%s)  ', tabs, name, link)
    end

    local s = titles[2].row - 1
    local e = s

    if idx then
      s = titles[idx].row - 1
      e = titles[idx + 1].row - 1
    else
      idx = 1
    end

    local indices = { '# Index' }
    for i, _ in ipairs(titles) do
      if i > idx then
        table.insert(indices, get_index_line(titles[i].value))
      end
    end
    table.insert(indices, '')
    vim.api.nvim_buf_set_lines(0, s, e, false, indices)
  end,
  {}
)
