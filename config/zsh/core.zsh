# Locale
export LANG="en_US.UTF-8"

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

# Environment Variables
export CDPATH=~:~/Documents:~/Documents/42:~/ghq/github.com/harsssh:~/ghq/github.com
export CLICOLOR=1
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
export MAKEFLAGS="SHELL=/bin/bash"
export GHUSER='harsssh'

# PATH Configuration
# Ensure PATH uniqueness
typeset -U path PATH

# Core PATH configuration
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
export PNPM_HOME="/Users/kemizuki/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Shell Options
# File and Directory Operations
setopt auto_param_slash      # Auto-append slash to directory names during tab completion
setopt mark_dirs             # Mark directory names with a trailing slash during listing
setopt list_types            # Indicate file types in directory listings
setopt auto_cd               # Auto-cd into a directory by typing its name

# Shell Interactivity
setopt auto_menu             # Auto-list choices on ambiguous tab completion
setopt auto_param_keys       # Enable key-based parameter name completion
setopt interactive_comments  # Allow comments in interactive shells
setopt always_last_prompt    # Ensure prompt is always the last line on terminal

# Globbing and Pattern Matching
setopt extended_glob         # Enable extended globbing features
setopt globdots              # Include filenames starting with a dot in wildcard matches
setopt list_packed           # Show globbed patterns as individual matches

# Miscellaneous
setopt magic_equal_subst     # Allow filename expansion after equals sign in parameters
setopt complete_in_word      # Allow tab completion in middle of word
setopt print_eight_bit       # Print 8th bit set characters as is, no metafication

# History
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt extended_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

# Completion System
autoload -U compinit && compinit -C
autoload -U bashcompinit && bashcompinit
autoload -U colors && colors

# Completion styles
zstyle ':completion:*:default' menu select=2                                           # select by arrow keys
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:options' description 'yes'

# Key Bindings
# bindkey -v


# Initialize Tools (cached for performance)
_zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ ! -d "$_zsh_cache_dir" ]] && mkdir -p "$_zsh_cache_dir"

# starship
_starship_cache="$_zsh_cache_dir/starship_init.zsh"
if [[ ! -f "$_starship_cache" || "$_starship_cache" -ot "$(command -v starship)" ]]; then
  starship init zsh > "$_starship_cache"
fi
source "$_starship_cache"

# mise
_mise_cache="$_zsh_cache_dir/mise_activate.zsh"
if [[ ! -f "$_mise_cache" || "$_mise_cache" -ot "$(command -v mise)" ]]; then
  mise activate zsh > "$_mise_cache"
fi
source "$_mise_cache"

# LLVM (disabled if NO_LLVM is set via mise.local.toml etc.)
if [ -z "$NO_LLVM" ] && [ -d "/opt/homebrew/opt/llvm" ]; then
  export CC="/opt/homebrew/opt/llvm/bin/clang"
  export CXX="/opt/homebrew/opt/llvm/bin/clang++"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
  export CPLUS_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
fi

# fzf
_fzf_cache="$_zsh_cache_dir/fzf_init.zsh"
if [[ ! -f "$_fzf_cache" || "$_fzf_cache" -ot "$(command -v fzf)" ]]; then
  fzf --zsh > "$_fzf_cache"
fi
source "$_fzf_cache"
