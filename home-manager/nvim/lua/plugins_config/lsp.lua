require("mason").setup()
mason = require("mason-lspconfig")
mason.setup({
    ensure_installed = { "rust_analyzer", "lua_ls", "clangd"}
})

local navic = require("nvim-navic")

local vim = vim
local map = vim.keymap.set;
local opts = { noremap = true, silent = true }
map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[e', vim.diagnostic.goto_prev, opts)
map('n', ']e', vim.diagnostic.goto_next, opts)
-- map('n', '<space>q', vim.diagnostic.setloclist, opts) -- use an on_attach function to only map thefollowing keys

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

     if client.server_capabilities.documentSymbolProvider then
         navic.attach(client, bufnr)
     end

    -- Disable lsp tokens highlight
    client.server_capabilities.semanticTokensProvider = nil

	-- enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- mappings.
	local lspfunc = vim.lsp.buf;
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map('n', 'go', '<cmd>symbolsoutline<cr>', bufopts)
	map('n', 'gd', lspfunc.declaration, bufopts)
	map('n', 'gd', lspfunc.definition, bufopts)
	map('n', '<S-k>', lspfunc.hover, bufopts)
	map('n', 'gi', lspfunc.implementation, bufopts)
	-- map('n', '<c-k>', lspfunc.signature_help, bufopts)
	map('n', '<space>wa', lspfunc.add_workspace_folder, bufopts)
	map('n', '<space>wr', lspfunc.remove_workspace_folder, bufopts)
	map('n', '<space>wl',
		function()
			print(vim.inspect(lspfunc.list_workspace_folders()))
		end, bufopts)
	map('n', '<space>d', lspfunc.type_definition, bufopts)
	map('n', '<space>rn', lspfunc.rename, bufopts)
	map('n', '<space>ca', lspfunc.code_action, bufopts)
	map('n', 'gr', lspfunc.references, bufopts)
	map('n', '<space>f', lspfunc.format, bufopts)
end

-- define cmp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- automatically setup installed servers
mason.setup_handlers({
    -- default handler
    function(server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,

    -- other handlers server specific handlers...

})

-- other handlers server specific handlers...
require("lspconfig").serve_d.setup {
    on_attach = on_attach,
    -- capabilities = capabilities,
    cmd = {'/usr/bin/env', 'serve-d'},
}

-- Lsp Control
map('n', "<leader>lr", [[:LspRestart<CR>]], opts)
map('n', "<leader>ld", [[:LspStop<CR>]], opts)
map('n', "<leader>ls", [[:LspStart<CR>]], opts)
map('n', "<leader>li", [[:LspInfo<CR>]], opts)
map('n', "<leader>lI", [[:LspInstall]], opts)
