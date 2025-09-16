# ============================================================================
# User Customizations
# ============================================================================

# ----------------------------------------------------------------------------
# Aliases - System Commands
# ----------------------------------------------------------------------------
# Use GNU coreutils if available
if command -v gls >/dev/null 2>&1; then
  alias ls='gls --color=auto'
  alias l='gls -CF --color=auto'
  alias la='gls -A --color=auto'
  alias ll='gls -alF --color=auto'
fi

# Zsh configuration shortcuts
alias zrc='vim ~/.zshrc'
alias zenv='vim ~/.zshenv'
alias reload="source ~/.zshenv && source ~/.zshrc"

# Safety and convenience
alias rm='rm -i'
alias mkdir='mkdir -p'
alias tgz='tar -xzvf'
alias ..='cd ..'

# ----------------------------------------------------------------------------
# Aliases - Development Tools
# ----------------------------------------------------------------------------
# Editors
alias vi='nvim'
alias vim='nvim'

# Package managers
alias pp='pnpm'
alias x="mise x --"

# Docker
alias dc="docker compose"

# Utilities
alias ff='fzf'
alias ffb='git branch --format="%(refname:short)" | fzf'
alias doc="cat << 'EOF'"

# ----------------------------------------------------------------------------
# Aliases - Git
# ----------------------------------------------------------------------------
alias g='git'
alias gpl='git pull'
alias gps='git push'
alias gs='git status'
alias gr='git reset'
alias grh='git reset --hard'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcp='git cherry-pick'
alias gl='git log --oneline --graph'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gcl='git clean -fd'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gsts='git stash show -p'
alias gstd='git stash drop'
alias gcb='git checkout -b'
alias gc='git checkout'
alias gcmain='git checkout main'
alias gcmaster='git checkout master'

# ----------------------------------------------------------------------------
# Custom Functions
# ----------------------------------------------------------------------------
# Interactive history search with fzf
function select-history() {
    BUFFER=$(history -nr 1 | fzf -q "$LBUFFER" --prompt="History> " --reverse)
    CURSOR=${#BUFFER}
}
zle -N select-history
bindkey '^r' select-history