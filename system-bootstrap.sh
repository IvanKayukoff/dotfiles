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
sudo pacman --noconfirm -S alsa-utils pulseaudio pavucontrol xorg-server \
  xorg-xinit mesa xorg-xinput htop git wget curl zsh make cmake terminator \
  openssh networkmanager network-manager-applet screen screenfetch \
  powerline-fonts ttf-ubuntu-font-family tamsyn-font ttf-droid ttf-dejavu \
  ttf-fira-code ttf-fira-sans awesome gdm compton xxkb firefox ranger \
  atool lynx ffmpegthumbnailer highlight mediainfo poppler python-chardet w3m \
  python-pip rxvt-unicode rxvt-unicode-terminfo xsel xorg-xfontsel gvim vlc \
  strace nautilus acpid playerctl cmus

sudo systemctl enable NetworkManager
sudo systemctl enable gdm

echo "Now we're going to install oh-my-zsh, so don't forget to press Ctrl+D when it'll be installed"
echo "Type \"yes\" if you agree:"
# Here should be check
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Pull dotfiles submodules
git submodule update --init --recursive
sh install-dotfiles.sh

# Installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

yay --noconfirm -S urxvt-perls gtk-theme-shades-of-gray

echo "set preview_images true"        > ~/.config/ranger/rc.conf
echo "set preview_images_method w3m" >> ~/.config/ranger/rc.conf

# Installing icons
git clone https://github.com/vinceliuice/Qogir-icon-theme.git
cd Qogir-icon-theme
sh Install
cd ..
rm -rf Qogir-icon-theme

# Setting the gtk theme and icons
mkdir -p ~/.config/gtk-3.0
GTK3_SETTINGS='~/.config/gtk-3.0/settings.ini'
echo '[Settings]'                            > $GTK3_SETTINGS
echo 'gtk-icon-theme-name = Qogir-dark'     >> $GTK3_SETTINGS
echo 'gtk-theme-name = Shades-of-gray-Arch' >> $GTK3_SETTINGS
echo 'gtk-font-name = Cantarell 11'         >> $GTK3_SETTINGS

echo "Bootstrap completed. Now you can reboot and run the next script"
# TODO Add the next script name

