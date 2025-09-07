# ============================================================================
# PATH Setup
# ============================================================================

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
  $path
  /Applications/WezTerm.app/Contents/MacOS
  ~/.ghcup/bin
)

# Additional PATH entries
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# ============================================================================
# Lazy Loading Functions
# ============================================================================

_lazy_load_mise() {
  eval "$(mise activate zsh)"
  precmd_functions=(${precmd_functions[@]/_lazy_load_mise/})
}

_lazy_load_direnv() {
  eval "$(direnv hook zsh)"
  precmd_functions=(${precmd_functions[@]/_lazy_load_direnv/})
}

_lazy_load_bun() {
  source ~/.bun/_bun
  precmd_functions=(${precmd_functions[@]/_lazy_load_bun/})
}

# ============================================================================
# Immediate Tool Initialization
# ============================================================================

# Critical tools loaded immediately for functionality
if [[ -n "${commands[starship]}" ]]; then
  eval "$(starship init zsh)"
fi

if [[ -n "${commands[fzf]}" ]]; then
  eval "$(fzf --zsh)"
fi

# ============================================================================
# Lazy-Loaded Tool Registration
# ============================================================================

# Register tools for lazy loading on first prompt
if [[ -n "${commands[mise]}" ]]; then
  precmd_functions+=(_lazy_load_mise)
fi

if [[ -n "${commands[direnv]}" ]]; then
  precmd_functions+=(_lazy_load_direnv)
fi

if [ -s ~/.bun/_bun ]; then
  precmd_functions+=(_lazy_load_bun)
fi

# ============================================================================
# Environment Sources
# ============================================================================

[ -f ~/.cargo/env ] && source ~/.cargo/env

# ============================================================================
# Completion Paths
# ============================================================================

# Docker CLI completions
fpath=(/Users/kentaro.mizuki/.docker/completions $fpath)

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
