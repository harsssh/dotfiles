local function has_biome_client(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "biome" then
      return true
    end
  end
  return false
end

local on_attach = function(client, bufnr)
  if client.name == "ts_ls" and has_biome_client(bufnr) then
    client.server_capabilities.documentFormattingProvider = false
  end
end

return {
  on_attach = on_attach
}
