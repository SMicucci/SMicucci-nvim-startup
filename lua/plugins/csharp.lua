--[[

All C# configuration have to stay here
> for this just include stuff to be sure it is included

--]]
return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- extra dependencies
      'mfussenegger/nvim-dap',
      'Saghen/blink.cmp',
    },
    config = function ()
      local dotnet = require 'easy-dotnet'
      local  blink = require 'blink.cmp'
      dotnet.setup{

      }

      -- import blink
      -- blink.add_provider('easy-dotnet', dotnet.package_completion_source)
    end
  }
}
