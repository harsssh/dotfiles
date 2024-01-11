# Others
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export LDFLAGS="-L/Users/kemizuki/.brew/opt/llvm/lib/c++ -Wl,-rpath,/Users/kemizuki/.brew/opt/llvm/lib/c++"
export CPLUS_INCLUDE_PATH=~/.brew/opt/llvm/include/c++/v1
export USER="kemizuki"
export MAIL="kemizuki@student.42tokyo.jp"
export CDPATH=~:~/Documents:~/Documents/42
export CLICOLOR=1
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
export LS_COLORS='di=94:ln=35:so=32:pi=33:ex=31:bd=46;94:cd=43;94:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LIBSQLITE=/usr/lib/libsqlite3.dylib

[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# ghcup-env
[ -f ~/.ghcup/env ] && source ~/.ghcup/env
# bun completions
[ -s ~/.bun/_bun ] && source ~/.bun/_bun
[ -f ~/.brewconfig.zsh ] && source ~/.brewconfig.zsh
