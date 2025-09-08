source ~/.zsh/env.zsh

source ~/.zsh/options.zsh
source ~/.zsh/zinit.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/path.zsh

# pnpm
export PNPM_HOME="/Users/kemizuki/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/kentaro.mizuki/.bun/_bun" ] && source "/Users/kentaro.mizuki/.bun/_bun"
