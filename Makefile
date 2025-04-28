STOW_DIRS := config git mise nvim starship zsh wezterm vim

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

