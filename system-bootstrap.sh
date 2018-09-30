#!/bin/bash

# TODO install essentials, oh-my-zsh

# installing vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# creating symlinks to .zshrc and .vimrc
mv ~/.zshrc ~/.zshrc.old
ln -s `pwd`/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc.old
ln -s `pwd`/.vimrc ~/.vimrc

# executing :PlugInstall silently
vim +PlugInstall +qall

