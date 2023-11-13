# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Environment
source ~/.zsh_aliases
source ~/.zsh_path

### File and Directory Operations
setopt auto_param_slash  # Auto-append slash to directory names during tab completion
setopt mark_dirs  # Mark directory names with a trailing slash during listing
setopt list_types  # Indicate file types in directory listings
setopt AUTO_CD  # Auto-cd into a directory by typing its name

### Shell Interactivity
setopt auto_menu  # Auto-list choices on ambiguous tab completion
setopt auto_param_keys  # Enable key-based parameter name completion
setopt interactive_comments  # Allow comments in interactive shells
setopt always_last_prompt  # Ensure prompt is always the last line on terminal

### Globbing and Pattern Matching
setopt extended_glob  # Enable extended globbing features
setopt globdots  # Include filenames starting with a dot in wildcard matches
setopt list_packed  # Show globbed patterns as individual matches

### Miscellaneous
setopt magic_equal_subst  # Allow filename expansion after equals sign in parameters
setopt complete_in_word  # Allow tab completion in middle of word
setopt print_eight_bit  # Print 8th bit set characters as is, no metafication

### Completion
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
zstyle ':completion:*:default' menu select=2 # select by arrow keys
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history # set the completion strategy sequence
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [No/Yes/Abort/Edit]"
. "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"

### Prompt and VSC
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz is-at-least
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true
zstyle ":vcs_info:*" max-exports 6
if is-at-least 4.3.10; then
  zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
  zstyle ":vcs_info:git:*" stagedstr "<S>"
  zstyle ":vcs_info:git:*" unstagedstr "<U>"
  zstyle ":vcs_info:git:*" formats "(%b) %c%u"
  zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi
function _update_vcs_info_msg() {
  psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="[$BLUE%~%f$DEFAULT%1(v|%F{green}%1v%f|)]"
add-zsh-hook precmd _update_vcs_info_msg

### History
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

### Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \

zinit wait lucid for \
    b4b4r07/enhancd \
    supercrabtree/k \
    zsh-users/zsh-syntax-highlighting

zinit ice depth=1
zinit light romkatv/powerlevel10k

### Epilogue
typeset -U path PATH
