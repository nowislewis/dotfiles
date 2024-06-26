stow_dirs = $(wildcard */)
.PYONY=stow
stow:
	stow --target $(HOME) --verbose $(stow_dirs)

download: emacs.d rime maple-font
emacs.d:
	git clone git@github.com:nowislewis/nowisemacs.git $(HOME)/.emacs.d
rime:
	git clone https://github.com/iDvel/rime-ice.git --depth=1 $(HOME)/Documents/rime
maple-font:
	wget -O $(HOME)/.fonts/maple.zip https://github.com/subframe7536/maple-font/releases/download/v6.4.1/MapleMono-SC-NF.zip

yay-backup:
	yay -Qqe > packages-repository.txt
yay-install:
	yay --needed -S - < packages-repository.txt

install-fish:
	git clone https://github.com/oh-my-fish/oh-my-fish ~/Downloads/oh-my-fish --depth=1
	~/Downloads/oh-my-fish/bin/install --offline --noninteractive
	fish -c "omf install foreign-env"
	fish -c "omf install z"

install-links:
	ln -s ~/Documents/emacs/08-keys/.authinfo ~/.authinfo
	ln -s ~/Documents/emacs/02-binary-files/12-wallpapers ~/Pictures
