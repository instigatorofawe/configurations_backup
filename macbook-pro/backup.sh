#!/bin/sh
cp -rf ~/.config/nvim .
rm -rf nvim/plugin
rm -rf nvim/yay-git

cp ~/.yabairc .
cp ~/.skhdrc .
cp ~/.alacritty.yml .
cp ~/.tmux.conf .

