{ pkgs, profile, lib, config, ... }:
{
  home.packages = [ pkgs.tig ];

  programs.git = lib.mkMerge [
    {
      enable = true;

      settings = {
        user = {
          name = "Kentaro Mizuki";
          email = "66548698+harsssh@users.noreply.github.com";
        };
        alias = {
          lg = "log --all --topo-order --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
          st = "status";
          co = "checkout";
          ps = "push";
          pl = "pull";
          c = "commit";
          cm = "commit -m";
          a = "add --all";
          f = "fetch --prune";
          b = "branch";
          r = "reset";
          sw = "switch";
          re = "restore";
          difft = "!GIT_EXTERNAL_DIFF=difft git diff";
          pushf = "push --force-if-includes --force-with-lease";
          cp = "cherry-pick";
          rb = "rebase";
        };
        core = {
          editor = "nvim";
          autocrlf = "input";
          fsmonitor = true;
        };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictStyle = "diff3";
          tool = "vimdiff";
        };
        mergetool.keepBackup = false;
        rerere.enabled = true;
        pull.rebase = false;
        init.defaultBranch = "main";
        advice.mergeConflict = false;
        url."git@github.com:".insteadOf = "https://github.com/";
        feature.manyFiles = true;
        log.abbrevCommit = true;
        filter.lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };
      };
    }
    (lib.mkIf (profile ? signingKey) {
      signing = {
        key =
          if config.features."1password".enable then
            "key::${profile.signingKey}"
          else
            profile.signingKeyFile or "~/.ssh/id_ed25519";
        signByDefault = true;
      };
      settings.gpg.format = "ssh";
    })
  ];

  # tig
  home.file.".tigrc".source = ../../config/.tigrc;
}
