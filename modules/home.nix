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
    enableCompletion = true;
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
    setOptions = [
      "auto_param_slash"
      "mark_dirs"
      "list_types"
      "auto_menu"
      "auto_param_keys"
      "interactive_comments"
      "always_last_prompt"
      "extended_glob"
      "globdots"
      "list_packed"
      "magic_equal_subst"
      "complete_in_word"
      "print_eight_bit"
      "hist_no_store"
      "hist_reduce_blanks"
      "hist_save_no_dups"
    ];
    completionInit = ''
      autoload -U compinit && compinit
      autoload -U bashcompinit && bashcompinit
      autoload -U colors && colors
      zstyle ':completion:*:default' menu select=2
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
      zstyle ':completion:*:options' description 'yes'
    '';
    shellAliases = {
      ls = "ls --color=auto";
      l = "ls -CF --color=auto";
      la = "ls -A --color=auto";
      ll = "ls -alF --color=auto";

      reload = "source ~/.zshrc";

      rm = "rm -i";
      mkdir = "mkdir -p";
      tgz = "tar -xzvf";
      ".." = "cd ..";

      vi = "nvim";
      vim = "nvim";

      pp = "pnpm";
      x = "mise x --";

      dc = "docker compose";

      ff = "fzf";
      ffb = ''git branch --format="%(refname:short)" | fzf'';

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

      tmux = "tmux -2";
      ta = "tmux attach -t";
      tad = "tmux attach -d -t";
      ts = "tmux new-session -s";
      tsd = "tmux new-session -d -s";
      tl = "tmux list-sessions";
      tksv = "tmux kill-server";
      tkss = "tmux kill-session -t";
    };
    initContent = ''
      # FIXME: OrbStack init is environment-specific
      source ~/.orbstack/shell/init.zsh 2>/dev/null || :
      eval "$(mise activate zsh)"
      eval "$(bun completions)"
    '';
  };

  # starship
  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ../config/starship/starship.toml;

  # fzf
  programs.fzf.enable = true;

  # tmux
  programs.tmux.enable = true;
}
