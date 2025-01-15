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
    if vim.fn.executable('markdown') then
      local name = string.gsub(vim.fn.bufname(), '%.md$', '')
      local cmd = string.format('markdown %s.md > %s.html', name, name)
      vim.fn.execute(cmd)
      -- TODO: check how to launch default browser page
    else
      vim.notify(string.format('to support real time view of %s.md install `$ markdown`', vim.fn.bufname()),
        vim.log.levels.WARN)
    end
  end,
  'Markdown create temporary html render'
)

-- delete html each time buffer is deleted
-- delete html each time buffer is hidden (avoid renaming from other type of event)
md_aucmd(
  { 'BufDelete', 'BufHidden' },
  function()
    local name = string.gsub(vim.fn.bufname(), '%.md$', '.html')
    if vim.fn.delete(name) == -1 then
      vim.notify(string.format('temporary file \'%\' not deleted!\n', name), vim.log.levels.ERROR)
    end
  end,
  'Markdown delete temporary html render'
)

