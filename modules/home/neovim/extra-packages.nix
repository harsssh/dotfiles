{ pkgs, ... }:
{
  # nixvim 自身が neovim を導入するので個別の neovim パッケージは不要
  home.packages = with pkgs; [
    # LSP servers
    lua-language-server
    nodePackages.typescript-language-server
    gopls

    # Formatters (none-ls から呼び出される)
    stylua
    gofumpt
    goimports-reviser
    biome
  ];
}
