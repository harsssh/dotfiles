# Others
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export LDFLAGS="-L/Users/kemizuki/.brew/opt/llvm/lib"
export CPPFLAGS="-I/Users/kemizuki/.brew/opt/llvm/include"
export CPLUS_INCLUDE_PATH="/Users/kemizuki/.brew/opt/llvm/include"
export USER="kemizuki"
export MAIL="kemizuki@student.42tokyo.jp"
export CDPATH=~:~/Documents:~/Documents/42
export CLICOLOR=1
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
export LS_COLORS='di=94:ln=35:so=32:pi=33:ex=31:bd=46;94:cd=43;94:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LIBSQLITE=/usr/lib/libsqlite3.dylib
export CC="/Users/kemizuki/.brew/opt/llvm/bin/clang"
export CXX="/Users/kemizuki/.brew/opt/llvm/bin/clang++"

[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ghcup-env
[ -f ~/.ghcup/env ] && source ~/.ghcup/env
# bun completions
[ -s ~/.bun/_bun ] && source ~/.bun/_bun
[ -f ~/.brewconfig.zsh ] && source ~/.brewconfig.zsh
