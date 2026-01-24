# Task Completion Checklist

When completing a task in this project, always perform the following:

## Required Steps

1. **Run `nix flake check`**
   - This validates the entire flake configuration
   - Must pass without errors before considering the task complete
   - Warnings should be addressed if possible

2. **Verify syntax**
   - Nix files should be properly formatted (use `nixfmt` if needed)
   - Lua files (in config/nvim) should have valid syntax

## Optional Steps (as needed)

3. **Test the configuration**
   - Run `make build` to verify the configuration builds
   - Run `make switch` to apply and test if necessary

4. **Check for warnings**
   - Address any deprecation warnings
   - Fix any configuration warnings from nix-darwin or home-manager

## Notes from CLAUDE.md
- Prioritize reproducibility
- Don't over-engineer; only Nix-ify what provides clear benefits
- Static configs go in `config/`, Nix modules go in `modules/`
