#!/bin/bash

PATH_OF_ZSHRC=`find . -maxdepth 1 -type f -name .zshrc`

if [[ $PATH_OF_ZSHRC != './.zshrc' ]]
then
  echo "Working directory must be is the root of dotfiles"
  exit 1
fi

if [[ `whoami` = 'root' ]]
then
  echo "To run this script you can't be logged in as root."
  echo "First of all create your own user who is groupmember of \"wheel\"."
  echo "Also, you have to permit members of wheel to execute any command."
  echo "You can do it under root via:"
  echo "sed -i 's/.*\(%wheel *ALL *= *( *ALL *) *ALL.*\)/\1/' /etc/sudoers"
  exit 1
fi

sudo true
IS_SUDO_FAILED=$?
if [[ $IS_SUDO_FAILED != '0' ]]
then
  echo "\"$USER\" must be a member of group \"wheel\""
  exit 1
fi

# Awesome brightness widget requires availability to run as root without password
echo "ALL ALL = (root) NOPASSWD: `pwd`/awesome/widgets/brightness/set_brightness.sh"\
  | sudo tee --append /etc/sudoers

# System update
sudo pacman --noconfirm -Syu

# Install essential programs and utilities
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
echo "Press \"Enter\" to continue.. "
read
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

mkdir -p ~/.config/ranger
echo "set preview_images true"        > ~/.config/ranger/rc.conf
echo "set preview_images_method w3m" >> ~/.config/ranger/rc.conf

# Installing icons
git clone https://github.com/vinceliuice/Qogir-icon-theme.git
cd Qogir-icon-theme
sh install.sh
cd ..
rm -rf Qogir-icon-theme

# Setting up "Time Won" font
curl -L https://www.1001freefonts.com/d/23641/time-won.zip -o time-won.zip
mkdir -p ~/.fonts
unzip time-won.zip -d ~/.fonts/
fc-cache -f -v
rm time-won.zip

# Setting the gtk theme and icons
mkdir -p ~/.config/gtk-3.0
GTK3_SETTINGS='~/.config/gtk-3.0/settings.ini'
echo '[Settings]'                            > $GTK3_SETTINGS
echo 'gtk-icon-theme-name = Qogir-dark'     >> $GTK3_SETTINGS
echo 'gtk-theme-name = Shades-of-gray-Arch' >> $GTK3_SETTINGS
echo 'gtk-font-name = Cantarell 11'         >> $GTK3_SETTINGS

echo "Bootstrap completed! Now you can reboot to start using awesome. Enjoy it ;)"

