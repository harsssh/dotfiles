if command -v gls >/dev/null 2>&1; then
  alias ls='gls --color=auto'
  alias l='gls -CF --color=auto'
  alias la='gls -A --color=auto'
  alias ll='gls -alF --color=auto'
fi

alias zrc='vim ~/.zshrc'
alias zenv='vim ~/.zshenv'
alias reload="source ~/.zshenv && source ~/.zshrc"
alias rm='rm -i'
alias mkdir='mkdir -p'
alias tgz='tar -xzvf'
alias g='git'
alias dc="docker compose"
alias vi='nvim'
alias vim='nvim'
alias ..='cd ..'
alias x="mise x --"
alias gff='git ls-files | fzf'
alias doc="cat << 'EOF'"

# git 系
alias gs='git status'
alias gr='git reset'
alias grh='git reset --hard'
alias grh~='git reset --hard HEAD~'
alias grs~='git reset --soft HEAD~'
alias ga='git add'
alias gai='git add -i'
alias gaa='git add -A'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch --all'
alias gbm='git branch -m'
alias gc='git commit --verbose'
alias gcm='git commit -m'
alias gaac='git add -A && git commit --verbose'
alias gaacm='git add -A && git commit -m'
alias gco='git checkout'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch --detach'
alias gres='git restore'
alias gresp='git restore -p'
alias gd='git diff'
alias gdh='git diff HEAD~..HEAD'
alias gds='git diff --staged'
