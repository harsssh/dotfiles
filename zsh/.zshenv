export LANG="en_US.UTF-8"

# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

if [[ -z "$SDKROOT" ]]; then
  local cache_file="$HOME/.cache/zsh_sdkroot"
  if [[ ! -f "$cache_file" || "$cache_file" -ot /usr/bin/xcrun ]]; then
    [[ ! -d "$HOME/.cache" ]] && mkdir -p "$HOME/.cache"
    command -v xcrun >/dev/null 2>&1 && xcrun --sdk macosx --show-sdk-path > "$cache_file" 2>/dev/null
  fi
  [[ -f "$cache_file" ]] && export SDKROOT=$(<"$cache_file")
fi

if [ -d "/opt/homebrew/opt/llvm" ]; then
  export CC="/opt/homebrew/opt/llvm/bin/clang"
  export CXX="/opt/homebrew/opt/llvm/bin/clang++"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
  export CPLUS_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
fi
