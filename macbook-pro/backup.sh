#!/bin/sh
cp -rf ~/.config/nvim ../
rm ../nvim/lazy-lock.json

cp ~/.yabairc .
cp ~/.skhdrc .
cp ~/.alacritty.toml .
cp ~/.tmux.conf .

