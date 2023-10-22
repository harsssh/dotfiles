DOTFILES := .gitconfig .ideavimrc .p10k.zsh .tool-versions .zsh_aliases .zshenv .zshrc .editorconfig
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
