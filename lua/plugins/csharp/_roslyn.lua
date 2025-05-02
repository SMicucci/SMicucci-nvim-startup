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

    local def_config = mauto.lsp_get_default()
    if def_config == nil or def_config.capabilities == nil then
      return
    end

    roslyn.setup {
      exe = {
        'dotnet',
        vim.fs.joinpath( roslyn_path, 'libexec', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
      },
      args = {
        '--stdio',
        '--logLevel=Information',
        '--extensionLogDirectory='..vim.fs.dirname(vim.lsp.get_log_path()),
        '--razorSourceGenerator='..vim.fs.joinpath( roslyn_path, 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
        '--razorDesignTimePath='..vim.fs.joinpath( razor_path, 'libexec', 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets')
      },
      ---@diagnostic disable-next-line: missing-fields
      config = {
        handlers = require 'rzls.roslyn_handlers',
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,

            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },
        },
        capabilities = def_config.capabilities,
      },
      broad_search = true,
    }

    mauto.install({'roslyn', 'rzls'})
    -- vim.tbl_deep_extend('keep',opts.config, mauto.lsp_get_default())
    -- roslyn.setup(opts)
  end,
  init = function ()
    vim.filetype.add {
      extension = {
        razor = 'razor',
        cshtml = 'razor',
      }
    }
  end

}
