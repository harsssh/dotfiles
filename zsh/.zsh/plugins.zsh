# ============================================================================
# Plugin Management with Zinit
# ============================================================================

# ----------------------------------------------------------------------------
# Zinit Installation & Initialization
# ----------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ----------------------------------------------------------------------------
# Plugin Loading
# ----------------------------------------------------------------------------
# Load essential plugins with turbo mode for faster startup
zinit wait lucid for \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-autosuggestions