typeset -U path PATH

PATH=/opt/homebrew/opt/coreutils/bin:$PATH
PATH=/opt/homebrew/opt/openssl@3/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=/opt/homebrew/opt/llvm/bin:$PATH
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"

# fzf
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi
# starship
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
# mise
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s ~/.bun/_bun ] && source ~/.bun/_bun
[ -f ~/.ghcup/env ] && source ~/.ghcup/env

