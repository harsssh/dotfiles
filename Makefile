STOW_DIRS := config git mise nvim nvim-minimal starship zsh

.PHONY: all
all: dry-run

.PHONY: dry-run
dry-run:
	stow -n $(STOW_DIRS)

.PHONY: apply
apply:
	stow $(STOW_DIRS)

.PHONY: clean
clean:
	stow -D $(STOW_DIRS)

