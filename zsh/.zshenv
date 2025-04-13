export LANG="en_US.UTF-8"
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export CC="/opt/homebrew/opt/llvm/bin/clang"
export CXX="/opt/homebrew/opt/llvm/bin/clang++"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CPLUS_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"

