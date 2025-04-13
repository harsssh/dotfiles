function select-history() {
    BUFFER=$(history -nr 1 | fzf -q "$LBUFFER" --prompt="History> " --reverse)
    CURSOR=${#BUFFER}
}
zle -N select-history
bindkey '^r' select-history
