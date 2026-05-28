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
    performance = {
      byteCompileLua.enable = true;
      combinePlugins.enable = true;
    };

    colorschemes.everforest = {
      enable = true;
      settings = {
        background = "medium";  # "soft" | "medium" | "hard"
        ui_contrast = "high";
      };
    };
  };
}
