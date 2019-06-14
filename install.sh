#!/bin/bash

# Install antigen.
curl -L git.io/antigen > ~/antigen.zsh

# Install vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install zsh and curl.
sudo apt-get update && sudo apt-get install zsh curl -y

# Install oh my zsh.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make a backup of the default .zshrc file.
cp ~/.zshrc ~/.zshrc.bak

# Install new .zshrc
cp .zshrc ~/.zshrc

# Install zsh theme.
cp classyTouch.zsh-theme ~/.oh-my-zsh/themes/

# Fetch new source.
echo 'Done!'
source ~/.zshrc
