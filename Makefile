GFIND := $(shell command -v gfind 2>/dev/null)
ifndef GFIND
$(error gfind not found. Run 'make deps' to install dependencies)
endif

STOW_DIRS := $(shell gfind . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f ')

.PHONY: all
all: dry-run

.PHONY: deps
deps:
	brew install findutils

.PHONY: dry-run
dry-run:
	stow -n $(STOW_DIRS)

.PHONY: apply
apply:
	stow $(STOW_DIRS)

.PHONY: clean
clean:
	stow -D $(STOW_DIRS)

