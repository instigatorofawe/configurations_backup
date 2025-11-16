#!/bin/sh
cp -rf ~/.config/nvim ../
rm -rf ../nvim/plugin
rm -rf ../nvim/yay-git
rm -rf ../nvim/lazy-lock.json

cp -rf ~/.config/i3 .
cp -rf ~/.config/i3status .
cp ~/.alacritty.toml .
cp ~/.tmux.conf .
cp ~/.config/starship.toml .

cp ~/.Xresources .
