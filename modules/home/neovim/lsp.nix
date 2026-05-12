{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      lua_ls.enable = true;
      gopls.enable = true;
      ts_ls = {
        enable = true;
        # フォーマットは none-ls に任せる
        onAttach.function = ''
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        '';
      };
      ruby_lsp = {
        enable = true;
        onAttach.function = ''
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        '';
      };
    };
  };
}
