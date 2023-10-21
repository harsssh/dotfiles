local lspconfig = require('lspconfig')

lspconfig['clangd'].setup({})

require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
    },
})
