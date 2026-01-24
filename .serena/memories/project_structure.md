# Project Structure

```
dotfiles/
├── flake.nix          # Main Nix flake entry point
├── flake.lock         # Locked flake dependencies
├── profiles.nix       # Profile definitions (work, personal)
├── Makefile           # Convenient commands for building/switching
├── CLAUDE.md          # Project-specific AI assistant instructions
├── modules/
│   ├── darwin/        # nix-darwin modules
│   │   ├── default.nix    # Main darwin config, home-manager integration
│   │   ├── system.nix     # macOS system settings
│   │   └── homebrew.nix   # Homebrew package definitions
│   └── home/          # home-manager modules
│       ├── default.nix    # Main home config, package lists, file symlinks
│       ├── shell.nix      # Shell-related settings
│       ├── zsh.nix        # Zsh configuration
│       ├── git.nix        # Git configuration
│       ├── neovim.nix     # Neovim setup
│       ├── tmux.nix       # Tmux configuration
│       └── editorconfig.nix
└── config/            # Static configuration files (not Nix expressions)
    ├── nvim/          # Neovim configuration (Lua)
    ├── vim/           # Vim configuration
    ├── tmux/          # Tmux configuration
    ├── claude/        # Claude Code settings
    ├── alacritty.toml
    ├── starship.toml
    ├── mise.toml
    └── ...
```

## Module Organization
- `modules/darwin/`: macOS system-level configurations using nix-darwin
- `modules/home/`: User-level configurations using home-manager
- `config/`: Static config files that are symlinked to appropriate locations
