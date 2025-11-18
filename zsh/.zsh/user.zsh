# Aliases - System Commands
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

# Aliases - Development Tools
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

# Aliases - Git
alias g='git'
alias gpl='git pull'
alias gps='git push'
alias gs='git status'
alias gr='git reset'
alias grh='git reset --hard'
alias grh~='git reset --hard HEAD~'
alias grs~='git reset --soft HEAD~'
alias ga='git add'
alias gai='git add -i'
alias gaa='git add -A'
alias gap='git add -p'
alias gan='git add -N'
alias gaan='git add -N -A'
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
alias gdn='git diff --name-only'
alias gmt='git mergetool'
alias glc='git log @{u}..HEAD --oneline'

# Aliases - Tmux
alias tmux='tmux -2'  # Force 256 color support
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tsd='tmux new-session -d -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias ccm='ccmanager'

# Custom Functions
# Interactive history search with fzf
function select-history() {
    BUFFER=$(history -nr 1 | fzf -q "$LBUFFER" --prompt="History> " --reverse)
    CURSOR=${#BUFFER}
}
zle -N select-history
bindkey '^r' select-history

# Auto-start tmux session
# 以下の条件を満たす場合に tmux を自動起動:
# - tmux がインストールされている
# - 既に tmux セッション内でない
# - SSH 接続でない、または SSH_TMUX 環境変数が設定されている
# - インタラクティブシェルである
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -z "$INSIDE_EMACS" ] && [[ $- == *i* ]]; then
    # SSH 接続の場合は SSH_TMUX=1 を設定することで自動起動を有効化
    if [ -z "$SSH_CONNECTION" ] || [ -n "$SSH_TMUX" ]; then
        # 既存のセッションがあれば接続、なければ新規作成
        tmux attach-session -t main 2>/dev/null || tmux new-session -s main
    fi
fi



# tmux ウィンドウ一覧を詳細表示
function tmux_windows() {
    if [[ -z "$TMUX" ]]; then
        tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name} [#{pane_current_command}]'
    else
        tmux list-windows -F '#I: #W [#{pane_current_command}]'
    fi
}

# エイリアス
alias tw='tmux_windows'
