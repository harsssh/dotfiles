DOTFILES := .editorconfig .gitconfig .ideavimrc .tigrc .tool-versions .zsh_aliases .zsh_finalize .zsh_path .zsh_zinit .zshenv .zshrc Brewfile
DOTFILES += .config/nvim

.PHONY: all
all: $(addprefix $(HOME)/,$(DOTFILES))

$(HOME)/.%: .%
	-ln -si $(PWD)/$< $@

$(HOME)/.config/nvim: .config/nvim
	-ln -si $(PWD)/$< $(dir $@)

.PHONY: clean
clean:
	-unlink -i $(addprefix $(HOME)/,$(DOTFILES))
