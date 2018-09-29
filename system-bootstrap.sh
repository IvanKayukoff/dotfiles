#!/bin/bash

# TODO install essentials, vim plugins, oh-my-zsh

# create symlinks to .zshrc and .vimrc
mv ~/.zshrc ~/.zshrc.old
ln -s `pwd`/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc
ln -s `pwd`/.vimrc ~/.vimrc

