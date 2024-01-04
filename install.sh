#!/bin/bash
list=(fish git zsh)
for i in ${list[*]}; do
    stow -t $HOME $i || exit -1
done
