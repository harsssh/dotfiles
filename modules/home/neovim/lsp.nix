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
        # プロジェクトの Ruby でビルドされた ruby-lsp を優先する。
        # nixvim 同梱版は別バージョンの Ruby に紐づくため、
        # ネイティブ拡張の読み込みが ABI 不一致で失敗する
        packageFallback = true;
      };
    };
  };
}
