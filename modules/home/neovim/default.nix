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

    colorschemes.kanagawa = {
      enable = true;
      settings.theme = "dragon";
    };
  };
}
