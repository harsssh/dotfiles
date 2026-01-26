{ ... }:
{
  system.defaults = {
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };

    dock = {
      autohide = true;
      show-recents = false;
    };

    NSGlobalDomain = {
      # キーボード
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.keyboard.fnState" = true;

      # トラックパッド
      "com.apple.trackpad.scaling" = 2.5;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.mouse.tapBehavior" = 1;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    WindowManager = {
      EnableTiledWindowMargins = false;
    };
  };
}
