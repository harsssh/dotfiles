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
