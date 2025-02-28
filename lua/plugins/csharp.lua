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
      'mfussenegger/nvim-dap'
    },
    config = function ()
      local dotnet = require 'easy-dotnet'
      dotnet.setup{

      }
    end
  }
}
