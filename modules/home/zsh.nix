{ config, ... }:
{
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
      autoload -Uz compinit
      # Rebuild completion cache when nix profile changes
      zcompdump="''${ZDOTDIR:-$HOME}/.zcompdump"
      if [[ -e "$zcompdump" && -e ~/.nix-profile && "$zcompdump" -nt ~/.nix-profile ]]; then
        compinit -C
      else
        compinit
      fi
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
      reload = "source ~/.zshrc";
    };
    initContent = ''
      [ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh
      eval "$(bun completions)"
    '';
  };
}
