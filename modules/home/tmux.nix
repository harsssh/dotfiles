{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
      yank
      vim-tmux-navigator
      prefix-highlight
    ];
    extraConfig = builtins.readFile ../../config/tmux/.tmux.conf;
  };
}
