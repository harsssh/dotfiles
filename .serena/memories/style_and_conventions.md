# Style and Conventions

## Nix Code Style
- Use `nixfmt` for formatting Nix files
- Prefer explicit imports over implicit ones
- Use `let...in` for local bindings
- Use `inherit` for passing through attributes

## Configuration Philosophy
- **Nix modules** (`modules/`): For configurations that benefit from Nix expressions (conditionals, package references, etc.)
- **Static configs** (`config/`): For configurations that are just plain files with no Nix benefits

## File Organization
- Darwin (system-level) modules: `modules/darwin/`
- Home-manager (user-level) modules: `modules/home/`
- Raw config files: `config/`

## Neovim Configuration
- Written in Lua
- Uses lazy.nvim for plugin management
- Plugin configs are organized in `config/nvim/lua/`:
  - `plugins/`: Plugin specifications
  - `config/`: Plugin configuration modules
  - `lsp/`: LSP-related configurations

## Language
- CLAUDE.md and documentation may be in Japanese
