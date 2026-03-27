NIX_CONFIG ?= $(if $(filter Darwin,$(shell uname -s)),work,linux)

.PHONY: build
build:
ifeq ($(shell uname -s),Darwin)
	darwin-rebuild build --flake .#$(NIX_CONFIG)
else
	home-manager build --flake .#$(NIX_CONFIG)
endif

.PHONY: switch
switch:
ifeq ($(shell uname -s),Darwin)
	darwin-rebuild switch --flake .#$(NIX_CONFIG)
else
	home-manager switch --flake .#$(NIX_CONFIG)
endif

.PHONY: check
check:
	nix flake check

.PHONY: update
update:
	nix flake update
