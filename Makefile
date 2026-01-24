NIX_CONFIG ?= work

.PHONY: build
build:
	darwin-rebuild build --flake .#$(NIX_CONFIG)

.PHONY: check
check:
	nix flake check

.PHONY: update
update:
	nix flake update
