STOW_DIRS := config git mise nvim nvim-minimal starship zsh
TARGET := $(HOME)

.PHONY: all
all: dry-run

.PHONY: dry-run
dry-run:
	stow -n -t $(TARGET) $(STOW_DIRS)

.PHONY: apply
apply:
	stow -t $(TARGET) $(STOW_DIRS)

.PHONY: clean
clean:
	stow -D -t $(TARGET) $(STOW_DIRS)

