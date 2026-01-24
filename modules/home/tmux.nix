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
  };

  home.file.".tmux.conf".source = ../../config/tmux/.tmux.conf;
}
