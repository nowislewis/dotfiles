#!/bin/bash
list=(fish git zsh tmux stardict pip hyprland)
for i in ${list[*]}; do
    stow -t $HOME $i || exit -1
done
