{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    neovim

    # LSP servers
    lua-language-server
    nodePackages.typescript-language-server
    gopls

    # Formatters
    stylua
    gofumpt
    goimports-reviser
    biome
  ];

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
}
