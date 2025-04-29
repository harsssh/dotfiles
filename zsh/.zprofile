# Added by Toolbox App
export PATH="$PATH:/Users/kmizuki/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# >>> coursier install directory >>>
export PATH="$PATH:/Users/kemizuki/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<


if command -v brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
