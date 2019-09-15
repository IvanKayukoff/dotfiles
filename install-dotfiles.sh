#!/bin/bash

mv ~/.zshrc ~/.zshrc.old 2>/dev/null
ln -s `pwd`/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc.old 2>/dev/null
ln -s `pwd`/.vimrc ~/.vimrc

mkdir -p ~/.config
mv ~/.config/i3 ~/.config/i3-old 2>/dev/null
ln -s `pwd`/i3 ~/.config

mv ~/.config/i3status ~/.config/i3status-old 2>/dev/null
ln -s `pwd`/i3status ~/.config

mv ~/.config/terminator ~/.config/terminator-old 2>/dev/null
ln -s `pwd`/terminator ~/.config

mv ~/.config/awesome ~/.config/awesome-old 2>/dev/null
ln -s `pwd`/awesome ~/.config

mv ~/.config/compton.conf ~/.config/compton.conf.old 2>/dev/null
ln -s `pwd`/compton.conf ~/.config

mv ~/.xprofile ~/.xprofile.old 2>/dev/null
ln -s `pwd`/.xprofile ~/.xprofile

mv ~/.Xresources ~/.Xresources.old 2>/dev/null
ln -s `pwd`/.Xresources ~/.Xresources

