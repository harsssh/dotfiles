{ config, lib, ... }:
let
  claudeDir = "${config.home.homeDirectory}/dotfiles/config/claude";
  link = path: config.lib.file.mkOutOfStoreSymlink "${claudeDir}/${path}";
  # synced/ は Claude Code が claude.ai から自動同期する skill のキャッシュで、
  # claude.ai のコネクタを前提にしたものが多く、Codex では使えない
  isOwnSkill = name: type: type == "directory" && name != "synced";
  skillNames = lib.attrNames (lib.filterAttrs isOwnSkill (builtins.readDir ../../config/claude/skills));
in
{
  home.file = {
    ".codex/AGENTS.md".source = link "CLAUDE.md";
  }
  // lib.listToAttrs (
    map (name: lib.nameValuePair ".agents/skills/${name}" { source = link "skills/${name}"; }) skillNames
  );
}
