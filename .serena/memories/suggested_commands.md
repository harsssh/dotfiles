# Suggested Commands

## Building and Applying Configuration

### Apply configuration (requires sudo)
```bash
make switch
# Or with specific profile:
make switch NIX_CONFIG=personal
```

### Build without applying
```bash
make build
# Or with specific profile:
make build NIX_CONFIG=personal
```

### Update flake inputs and apply
```bash
make update
```

## Validation

### Check flake (ALWAYS run after changes)
```bash
nix flake check
```

### Format Nix files
```bash
nixfmt <file.nix>
# Or format all:
find . -name "*.nix" -exec nixfmt {} \;
```

## System Utilities (macOS/Darwin)

- `ls`, `cd`, `grep`, `find`: Standard Unix commands (GNU versions installed via Nix)
- `git`: Version control
- `fd`: Fast file finder (alternative to find)
- `rg` (ripgrep): Fast text search (alternative to grep)
- `gh`: GitHub CLI
- `ghq`: Git repository manager
- `tree`: Directory tree viewer
- `jq`: JSON processor

## Default Profile
The default profile is `work` (NIX_CONFIG=work in Makefile).
