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
	yay -Qe > packages-repository.txt
yay-install:
	yay --needed -S - < packages-repository.txt
