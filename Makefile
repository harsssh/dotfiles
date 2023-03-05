all: link install-brew setup-brew setup-asdf install-dein keygen

.PHONY: link
link:
	find `pwd` -maxdepth 1 -name ".*" -or -name "Brewfile" | \
	grep -v -w -e ".git" -e ".idea" -e ".gitignore" -e ".DS_Store" | \
	xargs -I{} ln -sf {} ~

.PHONY: install-brew
install-brew:
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: setup-brew
setup-brew:
	brew bundle --global --force

.PHONY: install-dein
install-dein:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"

.PHONY: setup-asdf
setup-asdf:
	asdf install

# GitHub用
.PHONY: keygen
keygen:
	ssh-keygen -t rsa -b 4096 -C "" -f ~/.ssh/id_rsa -N "" -q
