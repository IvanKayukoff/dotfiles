#!/bin/bash

# TODO install essentials, oh-my-zsh

# creating symlinks to .zshrc and .vimrc
mv ~/.zshrc ~/.zshrc.old
ln -s `pwd`/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc.old
ln -s `pwd`/.vimrc ~/.vimrc

# setting wallpaper
feh --bg-scale PATH_TO_PICTURE

mkdir -p ~/.config
mv ~/.config/i3 ~/.config/i3-old
ln -s `pwd`/i3 ~/.config

sudo ln -s `pwd`/asgard_backup_push.sh /usr/local/bin/asgard_backup_push

