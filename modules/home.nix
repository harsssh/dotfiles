{ config, pkgs, ... }:
let
  llvm = pkgs.llvmPackages;
in
{
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    neovim
    nixfmt

    # CLI tools
    coreutils
    difftastic
    fd
    findutils
    gh
    ghq
    gnused
    jq
    pstree
    ripgrep
    tldr
    tree
    watch
    wget

    # JavaScript/Node
    bun
    pnpm

    # LLVM
    llvm.clang
  ];
  programs.home-manager.enable = true;

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    CLICOLOR = "1";
    MAKEFLAGS = "SHELL=/bin/bash";
    GHUSER = "harsssh";
    CC = "${llvm.clang}/bin/clang";
    CXX = "${llvm.clang}/bin/clang++";
    CDPATH = builtins.concatStringsSep ":" [
      config.home.homeDirectory
      "${config.home.homeDirectory}/Documents"
      "${config.home.homeDirectory}/ghq/github.com"
    ];
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.ghcup/bin"
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history = {
      path = "${config.home.homeDirectory}/.zhistory";
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreAllDups = true;
      extended = true;
      share = true;
    };
    historySubstringSearch.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      l = "ls -CF --color=auto";
      la = "ls -A --color=auto";
      ll = "ls -alF --color=auto";

      reload = "source ~/.zshrc";

      # Safety and convenience
      rm = "rm -i";
      mkdir = "mkdir -p";
      tgz = "tar -xzvf";
      ".." = "cd ..";

      # Editors
      vi = "nvim";
      vim = "nvim";

      # Package managers
      pp = "pnpm";
      x = "mise x --";

      # Docker
      dc = "docker compose";

      # Utilities
      ff = "fzf";
      ffb = ''git branch --format="%(refname:short)" | fzf'';

      # Git
      g = "git";
      gpl = "git pull";
      gps = "git push";
      gs = "git status";
      gr = "git reset";
      grh = "git reset --hard";
      "grh~" = "git reset --hard HEAD~";
      "grs~" = "git reset --soft HEAD~";
      ga = "git add";
      gai = "git add -i";
      gaa = "git add -A";
      gap = "git add -p";
      gan = "git add -N";
      gaan = "git add -N -A";
      gb = "git branch";
      gba = "git branch --all";
      gbm = "git branch -m";
      gc = "git commit --verbose";
      gcm = "git commit -m";
      gaac = "git add -A && git commit --verbose";
      gaacm = "git add -A && git commit -m";
      gco = "git checkout";
      gsw = "git switch";
      gswc = "git switch --create";
      gswd = "git switch --detach";
      gres = "git restore";
      gresp = "git restore -p";
      gd = "git difft";
      gdh = "git difft HEAD~..HEAD";
      gds = "git difft --staged";
      gdn = "git diff --name-only";
      gmt = "git mergetool";
      glc = "git log @{u}..HEAD --oneline";

      # Tmux
      tmux = "tmux -2";
      ta = "tmux attach -t";
      tad = "tmux attach -d -t";
      ts = "tmux new-session -s";
      tsd = "tmux new-session -d -s";
      tl = "tmux list-sessions";
      tksv = "tmux kill-server";
      tkss = "tmux kill-session -t";
      tw = "tmux_windows";

      ccm = "ccmanager";
    };
    initContent = ''
      source ~/.config/zsh/extra.zsh
      eval "$(bun completions)"
    '';
  };

  # Extra zsh config (PATH, tool init, functions)
  xdg.configFile."zsh/extra.zsh".source = ../config/zsh/extra.zsh;

  # starship
  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;

  # fzf
  programs.fzf.enable = true;

  # tmux
  programs.tmux.enable = true;
}
