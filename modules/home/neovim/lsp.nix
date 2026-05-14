{ config, ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      lua_ls.enable = true;
      gopls.enable = true;
      ts_ls.enable = true;
      ruby_lsp = {
        enable = true;
        # nix store は read-only なので GEM_HOME を書き込み可能なパスに向ける
        extraOptions.cmd_env = {
          GEM_HOME = "${config.home.homeDirectory}/.local/share/ruby-lsp-gems";
        };
      };
    };
  };
}
