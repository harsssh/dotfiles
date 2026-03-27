.PHONY: build
build:
ifeq ($(shell uname -s),Darwin)
	darwin-rebuild build --flake .
else
	home-manager build --flake .
endif

.PHONY: switch
switch:
ifeq ($(shell uname -s),Darwin)
	darwin-rebuild switch --flake .
else
	home-manager switch --flake .
endif

.PHONY: check
check:
	nix flake check

.PHONY: update
update:
	nix flake update
