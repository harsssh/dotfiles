export LANG="en_US.UTF-8"

if command -v xcrun >/dev/null 2>&1; then
  export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
fi

if [ -d "/opt/homebrew/opt/llvm" ]; then
  export CC="/opt/homebrew/opt/llvm/bin/clang"
  export CXX="/opt/homebrew/opt/llvm/bin/clang++"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
  export CPLUS_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
fi
