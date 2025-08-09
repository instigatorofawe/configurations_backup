#!/bin/sh
cp -rf ~/.config/nvim ../
rm ../nvim/lazy-lock.json

cp ~/.alacritty.toml .
cp ~/.tmux.conf .
cp ~/.aerospace.toml .
cp ~/.config/starship.toml .
cp ~/.wezterm.lua .

