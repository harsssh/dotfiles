NIX_CONFIG ?= work

.PHONY: switch
switch:
	sudo darwin-rebuild switch --flake .#$(NIX_CONFIG)

.PHONY: build
build:
	darwin-rebuild build --flake .#$(NIX_CONFIG)

.PHONY: update
update:
	nix flake update
	sudo darwin-rebuild switch --flake .#$(NIX_CONFIG)
