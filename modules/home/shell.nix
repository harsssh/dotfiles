{ config, pkgs, ... }:
let
  llvm = pkgs.llvmPackages;
in
{
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

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

  home.shellAliases = {
    ls = "eza";
    l = "eza --classify";
    la = "eza --all";
    ll = "eza --long --all --group";

    rm = "rm -i";
    mkdir = "mkdir -p";
    tgz = "tar -xzvf";
    ".." = "cd ..";

    vi = "nvim";
    vim = "nvim";

    pp = "pnpm";

    dc = "docker compose";
    pc = "process-compose";

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
}
