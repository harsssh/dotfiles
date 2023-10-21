# PATH
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/usr/local/opt/python/libexec/bin
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=/opt/homebrew/opt/openssl@3/bin:$PATH
export PATH=~/.asdf/shims:$PATH
export PATH=$PATH:~/.local/bin
export PATH=/opt/homebrew/opt/llvm/bin:$PATH
export PATH=~/.bun/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=$PATH:~/clangd/bin

# Others
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export USER="kemizuki"
export MAIL="kemizuki@student.42tokyo.jp"
export CDPATH=~:~/Documents:~/Documents/42
export CLICOLOR=1
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
export LS_COLORS='di=94:ln=35:so=32:pi=33:ex=31:bd=46;94:cd=43;94:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LIBSQLITE=/usr/lib/sqlite/libsqlite3.dylib

[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# ghcup-env
[ -f ~/.ghcup/env ] && source ~/.ghcup/env
# bun completions
[ -s ~/.bun/_bun ] && source ~/.bun/_bun
[ -f ~/.brewconfig.zsh ] && source ~/.brewconfig.zsh