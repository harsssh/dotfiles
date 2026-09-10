.PHONY: check
check:
	nix flake check

.PHONY: update
update:
	nix flake update
