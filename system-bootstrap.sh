#!/bin/bash

# TODO install essentials, oh-my-zsh

# creating symlinks to .zshrc and .vimrc
mv ~/.zshrc ~/.zshrc.old
ln -s `pwd`/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc.old
ln -s `pwd`/.vimrc ~/.vimrc

sudo ln -s `pwd`/asgard_backup_push.sh /usr/local/bin/asgard_backup_push

