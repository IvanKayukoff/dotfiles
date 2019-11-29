#!/bin/bash

# Creates soft link to the $dotfile_name and places it to $desired_path.
# Also, the function saves old version of a file that located in $desired_path.
# $dotfile_name is a relative path to file/directory starting from 
#               the dotfile repository root.
# $desired_path is a absolute path to the desired location of the new symlink.
new_safe_symlink () {
  local dotfile_name="$1"
  local desired_path="$2"
  mv "$desired_path" "$desired_path.old" 2>/dev/null
  ln -s "`pwd`/$dotfile_name" "$desired_path"
}

new_safe_symlink ".zshrc"       "$HOME/.zshrc"
new_safe_symlink ".vimrc"       "$HOME/.vimrc"

mkdir -p ~/.config

new_safe_symlink "i3"           "$HOME/.config/i3"
new_safe_symlink "i3status"     "$HOME/.config/i3status"
new_safe_symlink "terminator"   "$HOME/.config/terminator"
new_safe_symlink "awesome"      "$HOME/.config/awesome"
new_safe_symlink ".xprofile"    "$HOME/.xprofile"
new_safe_symlink ".Xresources"  "$HOME/.Xresources"
new_safe_symlink ".screenrc"    "$HOME/.screenrc"

