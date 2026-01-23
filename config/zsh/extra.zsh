# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# SDKROOT (cached for performance)
if [[ -z "$SDKROOT" ]]; then
  local cache_file="$HOME/.cache/zsh_sdkroot"
  if [[ ! -f "$cache_file" || "$cache_file" -ot /usr/bin/xcrun ]]; then
    [[ ! -d "$HOME/.cache" ]] && mkdir -p "$HOME/.cache"
    command -v xcrun >/dev/null 2>&1 && xcrun --sdk macosx --show-sdk-path > "$cache_file" 2>/dev/null
  fi
  [[ -f "$cache_file" ]] && export SDKROOT=$(<"$cache_file")
fi

# CDPATH
export CDPATH=~:~/Documents:~/Documents/42:~/ghq/github.com/harsssh:~/ghq/github.com

# PATH Configuration
typeset -U path PATH
path=(
  /opt/homebrew/opt/coreutils/bin
  /opt/homebrew/opt/openssl@3/bin
  ~/.local/bin
  /opt/homebrew/opt/llvm/bin
  ~/.local/go/bin
  ~/nvim/bin
  /usr/local/bin
  $path
  /Applications/WezTerm.app/Contents/MacOS
  ~/.ghcup/bin
)

# Bun
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# pnpm
export PNPM_HOME="/Users/kentaro.mizuki/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Shell Options (auto_cd is set by home-manager)
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt always_last_prompt
setopt extended_glob
setopt globdots
setopt list_packed
setopt magic_equal_subst
setopt complete_in_word
setopt print_eight_bit
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups

# Completion System
autoload -U compinit && compinit -C
autoload -U bashcompinit && bashcompinit
autoload -U colors && colors

# Completion styles
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:options' description 'yes'

# mise
_zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ ! -d "$_zsh_cache_dir" ]] && mkdir -p "$_zsh_cache_dir"
_mise_cache="$_zsh_cache_dir/mise_activate.zsh"
if [[ ! -f "$_mise_cache" || "$_mise_cache" -ot "$(command -v mise)" ]]; then
  mise activate zsh > "$_mise_cache"
fi
source "$_mise_cache"

# LLVM (disabled if NO_LLVM is set)
if [ -z "$NO_LLVM" ] && [ -d "/opt/homebrew/opt/llvm" ]; then
  export CC="/opt/homebrew/opt/llvm/bin/clang"
  export CXX="/opt/homebrew/opt/llvm/bin/clang++"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
  export CPLUS_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
fi

# Custom Functions
function select-history() {
  BUFFER=$(history -nr 1 | fzf -q "$LBUFFER" --prompt="History> " --reverse)
  CURSOR=${#BUFFER}
}
zle -N select-history
bindkey '^r' select-history

function tmux_windows() {
  if [[ -z "$TMUX" ]]; then
    tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name} [#{pane_current_command}]'
  else
    tmux list-windows -F '#I: #W [#{pane_current_command}]'
  fi
}
