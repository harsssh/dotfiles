{ inputs, ... }:
{
  xdg.configFile."alacritty/themes".source = "${inputs.alacritty-theme}/themes";

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "~/.config/alacritty/themes/miasma.toml" ];
      colors = {
        primary.background = "#000000";
        normal.red = "#a65d57";
        bright.red = "#c47a72";
      };
      env.TERM = "xterm-256color";
      window = {
        decorations = "Full";
        option_as_alt = "Both";
        opacity = 1.0;
      };
      font = {
        size = 14;
        normal = {
          family = "MonaspiceAr Nerd Font";
          style = "Regular";
        };
      };
      scrolling = {
        history = 100000;
        multiplier = 3;
      };
      bell.duration = 0;
      cursor.style.blinking = "Off";
      terminal.shell.program = "/bin/zsh";
      keyboard.bindings = [
        {
          key = "Return";
          mods = "Shift";
          chars = "\\n";
        }
      ];
    };
  };
}
