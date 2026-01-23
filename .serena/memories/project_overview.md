# Project Overview

## Purpose
This is a personal dotfiles repository for managing system and application configurations on macOS using Nix.

## Tech Stack
- **Nix Flakes**: For declarative and reproducible configuration management
- **nix-darwin**: For macOS system configuration
- **home-manager**: For user-level dotfile management
- **Homebrew**: For additional macOS package management (via nix-darwin)

## Target System
- macOS (Darwin) on Apple Silicon (aarch64-darwin)

## Profiles
Two profiles are defined in `profiles.nix`:
- `work`: username `kentaro.mizuki`
- `personal`: username `kemizuki`

## Design Philosophy
- Prioritize reproducibility
- Not everything needs to be Nix-managed; use Nix where it provides clear benefits
- Configuration files that don't benefit from Nix expressions are placed in `config/` and symlinked
