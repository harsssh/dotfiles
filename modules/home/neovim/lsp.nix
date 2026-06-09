{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      lua_ls.enable = true;
      gopls.enable = true;
      ts_ls.enable = true;
      ruby_lsp = {
        enable = true;
      };
    };
  };
}
