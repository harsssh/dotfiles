local lspconfig = require('lspconfig')

lspconfig['clangd'].setup({})

lspconfig['rust_analyzer'].setup({
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
    },
})
