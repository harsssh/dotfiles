local on_attach = function(client, bufnr)
  -- none-ls に任せる
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

return {
  on_attach = on_attach
}
