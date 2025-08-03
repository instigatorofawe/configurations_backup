#!/bin/sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install neovim neofetch htop aerospace starship tmux
brew install --cask miniforge

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git config --global user.name "Ran Liu"
git config --global user.email "ran.liu.2021@gmail.com"
git config --global core.editor "nvim"
