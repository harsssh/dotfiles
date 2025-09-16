# ============================================================================
# Zsh Configuration Entry Point
# ============================================================================
# This file serves as the clean entry point for all zsh configurations.
# All actual configuration is organized in ~/.zsh/ directory.
# ============================================================================

# Load core configuration (environment, PATH, options, completion)
source ~/.zsh/core.zsh

# Load plugin management (zinit)
source ~/.zsh/plugins.zsh

# Load user customizations (aliases, functions)
source ~/.zsh/user.zsh