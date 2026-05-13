{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.haskell-vim
      pkgs.vimPlugins.vim-tmux
    ];
  };
}
