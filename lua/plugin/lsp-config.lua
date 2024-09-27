-- setup lspconfig on_attach var
local on_attach = function(client, buf)
	local nmap = function(keys, func, desc)
		vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
	end

	if vim.g.plugs["omnisharp-extended-lsp.nvim"] ~= nil and client.name == 'omnisharp' then
		nmap('gd', require('omnisharp_extended').telescope_lsp_definition, '[G]oto [D]efinition')
		nmap('gr', require('omnisharp_extended').telescope_lsp_references, '[G]oto [R]eference')
		nmap('<Leader>D', require('omnisharp_extended').telescope_lsp_type_definitions, 'Type [D]efinition')
	else
		if vim.g.plugs["telescope.nvim"] ~= nil then
			nmap('gd', require('telescope.builtin').lsp_definition, '[G]oto [D]efinition')
			nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eference')
			nmap('<Leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
		end
	end
	if vim.g.plugs["telescope.nvim"] ~= nil then
		nmap('<Leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	end
	nmap('<Leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]action')
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

--	setup lspconfig capabilities var
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- setup mason
require('mason').setup()


-- mason-lspconfig install servers
require('mason-lspconfig').setup()

--	mason-lspconfig handler
require('mason-lspconfig').setup_handlers({
	function (server_name)
		require('lspconfig')[server_name].setup {
			on_attach = on_attach, capabilities = capabilities
		}
	end,
	["omnisharp"] = function ()
		require('lspconfig').omnisharp.setup {
			on_attach = on_attach, capabilities = capabilities,
			cmd = {'/home/simone/.local/share/nvim/mason/bin/omnisharp'},
			handlers = {
				["textDocument/definition"] = require('omnisharp_extended').definition_handler,
				["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
				["textDocument/references"] = require('omnisharp_extended').references_handler,
				["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
			},
			settings = {
				FormattingOptions = {
					EnableEditorConfigSupport = true,
				}
			},
		}
	end,
	["csharp_ls"] = function ()
		require('lspconfig').csharp_ls.setup {
			on_attach = on_attach, capabilities = capabilities,
			cmd = {'csharp-ls'},
			handlers = {
				["textDocument/definition"] = require('csharpls_extended').handler,
				["textDocument/typeDefinition"] = require('csharpls_extended').handler,
			},
		}
	end,
	["lua_ls"] = function ()
		require('lspconfig').lua_ls.setup {
			on_attach = on_attach, capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { enable = true, globals = {'vim','require'}, },
					workspace = { library = { vim.api.nvim_get_runtime_file("", true) }, },
				},
			},
		}
	end
})
