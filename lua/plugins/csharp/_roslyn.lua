return {
  "tris203/rzls.nvim",
  dependencies = {
    "seblj/roslyn.nvim",
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  ft = {'cs', 'cshtml', 'vb', 'razor'},
  config = function ()
    local mauto = require 'mason-automation'
    local roslyn = require 'roslyn'
    local roslyn_path = vim.fs.joinpath(
      vim.fn.stdpath'data'--[[@as string]],
      'mason', 'packages', 'roslyn')
    local razor_path = vim.fs.joinpath(
      vim.fn.stdpath'data'--[[@as string]],
      'mason', 'packages', 'rzls')
    local opts = {
      exe = {
        'dotnet',
        vim.fs.joinpath( roslyn_path, 'libexec', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
      },
      args = {
        '--logLevel=Information',
        '--extensionLogDirectory='..vim.fs.dirname(vim.lsp.get_log_path()),
        '--stdio',
        '--razorSourceGenerator='..vim.fs.joinpath( roslyn_path, 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
        '--razorDesignTimePath='..vim.fs.joinpath( razor_path, 'libexec', 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets')
      },
      config = {
        handlers = require 'rzls.roslyn_handlers',
      },
      broad_search = true,
    }

    mauto.install({'roslyn', 'rzls'})
    vim.tbl_deep_extend('keep',opts.config, mauto.lsp_get_default())
    roslyn.setup(opts)
  end

}
