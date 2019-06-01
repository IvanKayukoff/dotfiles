#!/bin/bash

echo "First of all create your own user who is groupmember of \"wheel\"."
echo "Next you have to uncomment line with text below to allow members of"
echo "group \"wheel\" to execute any command:"
echo '%wheel ALL=(ALL) ALL'
echo "In the \"/etc/sudoers\" file."
echo "Type \"yes\" if you've already done that:"
# Here should be check

# Check that runner isn't root

sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -S alsa-utils pulseaudio pavucontrol
sudo pacman --noconfirm -S xorg-server xorg-xinit mesa

sudo pacman --noconfirm -S vim htop git wget curl zsh make cmake terminator openssh networkmanager network-manager-applet
sudo systemctl enable NetworkManager

sudo pacman --noconfirm -S powerline-fonts ttf-ubuntu-font-family tamsyn-font ttf-droid ttf-dejavu ttf-fira-code ttf-fira-sans

sudo pacman --noconfirm -S awesome gdm compton xxkb firefox
sudo systemctl enable gdm

echo "Now we're going to install oh-my-zsh, so don't forget to press Ctrl+D when it'll be installed"
echo "Type \"yes\" if you agree:"
# Here should be check
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Pull dotfiles submodules
git submodule update --recursive
sh install-dotfiles.sh

# Installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

echo "Bootstrap completed. Now you can reboot and run the next script" # Add the next script name

