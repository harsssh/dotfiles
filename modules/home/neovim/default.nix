{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./diagnostics.nix
    ./lsp.nix
    ./extra-packages.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    performance.byteCompileLua.enable = true;

    # Ruby provider は使っていない。有効だと nvim のラッパーが GEM_HOME を
    # 自身の gem 環境へ上書きし、LSP など子プロセスの gem 解決を壊す
    withRuby = false;

    colorschemes.everforest = {
      enable = true;
      settings = {
        background = "medium";  # "soft" | "medium" | "hard"
        ui_contrast = "high";
      };
    };
  };
}
