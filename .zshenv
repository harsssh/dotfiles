# Others
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CPLUS_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
export USER="kemizuki"
export MAIL="kemizuki@student.42tokyo.jp"
export CDPATH=~:~/Documents:~/Documents/42:~/ghq/github.com/harsssh:~/ghq/github.com
export CLICOLOR=1
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
export LS_COLORS='di=94:ln=35:so=32:pi=33:ex=31:bd=46;94:cd=43;94:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CC="/opt/homebrew/opt/llvm/bin/clang"
export CXX="/opt/homebrew/opt/llvm/bin/clang++"
export LANG="en_US.UTF-8"

export LESS='-R'
export LESS_TERMCAP_mb=$'\e[1;31m'    # Blink - 赤色 (必要なら変更)
export LESS_TERMCAP_md=$'\e[1;34m'    # Bold - 明るい青色
export LESS_TERMCAP_me=$'\e[0m'       # Reset
export LESS_TERMCAP_se=$'\e[0m'       # Reset
export LESS_TERMCAP_so=$'\e[1;43;30m' # Standout mode - 明るい黄色の背景に黒の文字
export LESS_TERMCAP_ue=$'\e[0m'       # Reset
export LESS_TERMCAP_us=$'\e[1;36m'    # Underline - 明るいシアン

[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# bun completions
[ -s ~/.bun/_bun ] && source ~/.bun/_bun
. "$HOME/.cargo/env"
