.PHONY: all
all: dry-run

.PHONY: deps
deps:
	brew install findutils

ifneq ($(MAKECMDGOALS),deps)
GFIND := $(shell command -v gfind 2>/dev/null)
ifndef GFIND
$(error gfind not found. Run 'make deps' to install dependencies)
endif
endif

STOW_DIRS := $(shell gfind . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f ')

.PHONY: dry-run
dry-run:
	stow -n $(STOW_DIRS)

.PHONY: apply
apply:
	stow $(STOW_DIRS)

.PHONY: clean
clean:
	stow -D $(STOW_DIRS)

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

