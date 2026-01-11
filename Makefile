# +------+
# | stow |
# +------+
stow_dirs = $(wildcard */)
.PYONY=stow
.DEFAULT_GOAL := stow

stow:
	stow --target $(HOME) --verbose $(stow_dirs)

# +---------+
# | install |
# +---------+
install: emacs.d emacs rime maple-font zsh fish links

# ┌───────┐
# │ check │
# └───────┘
# this file will be used to check with parallel	in "install"
checked-all: checked-folder checked-ssh
	touch checked-all

checked-folder:
	mkdir -p ${HOME}/Documents
	mkdir -p ${HOME}/Downloads
	touch checked-folder

checked-ssh:
	@test -d "$(HOME)/.ssh" || (echo "Error: ~/.ssh directory not found" && exit 1)
	touch checked-ssh

# ┌─────────┐
# │ plugins │
# └─────────┘

emacs.d: checked-all
	git clone git@github.com:nowislewis/nowisemacs.git $(HOME)/.emacs.d

emacs:  checked-all
	git clone --recurse-submodules -j8 git@github.com:nowislewis/emacs.git $(HOME)/Documents/emacs

rime:  checked-all
	git clone https://github.com/iDvel/rime-ice.git --depth=1 $(HOME)/Documents/rime

maple-font:  checked-all
	rm -rf ${HOME}/.fonts/maple
	mkdir -p ${HOME}/.fonts/maple
	cd ${HOME}/.fonts/maple && \
		wget -O maple.zip https://github.com/subframe7536/maple-font/releases/download/v7.9/MapleMono-NF-CN.zip	&& \
		unzip maple.zip && \
		rm maple.zip && \
	fc-cache -fv
zsh:
	rm -rf ~/.zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

fish: checked-all
	git clone https://github.com/oh-my-fish/oh-my-fish ~/Downloads/oh-my-fish --depth=1
	~/Downloads/oh-my-fish/bin/install --offline --noninteractive
	fish -c "omf install foreign-env"

links: emacs
	ln -s ~/Documents/emacs/08-keys/.authinfo ~/.authinfo
	ln -s ~/Documents/emacs/02-binary-git/binary-files/12-wallpapers ~/Pictures

# +--------+
# | backup |
# +--------+

yay-bk:
	yay -Qqe > packages-repository.txt
yay-install:
	yay --needed -S - < packages-repository.txt
