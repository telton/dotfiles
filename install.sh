#!/bin/bash

# Install zsh.
sudo apt-get update && sudo apt-get install zsh curl git -y

# Install oh-my-zsh.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install angtigen.
curl -L git.io/antigen > antigen.zsh

# Install Vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
