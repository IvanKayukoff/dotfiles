#!/bin/bash

mv ~/.zshrc ~/.zshrc.old
ln -s `pwd`/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc.old
ln -s `pwd`/.vimrc ~/.vimrc

mkdir -p ~/.config
mv ~/.config/i3 ~/.config/i3-old
ln -s `pwd`/i3 ~/.config

mv ~/.config/i3status ~/.config/i3status-old
ln -s `pwd`/i3status ~/.config

mv ~/.config/terminator ~/.config/terminator-old
ln -s `pwd`/terminator ~/.config

mv ~/.config/awesome ~/.config/awesome-old
ln -s `pwd`/awesome ~/.config

mv ~/.xprofile ~/.xprofile.old
ln -s `pwd`/.xprofile ~/.xprofile

