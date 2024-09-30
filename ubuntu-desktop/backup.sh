#!/bin/sh
cp -rf ~/.config/nvim ../
rm -rf ../nvim/plugin
rm -rf ../nvim/yay-git

cp -rf ~/.config/i3 .
cp -rf ~/.config/i3status .
cp ~/.alacritty.yml .
cp ~/.tmux.conf .

cp ~/.Xresources .
