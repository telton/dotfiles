#!/bin/bash

git_name="Tyler Elton"
git_email="telton007@gmail.com"

case `uname` in
    Darwin)
        ./install_osx.sh
    ;;
    Linux)
        ./install_linux.sh
    ;;
esac

# Install oh-my-zsh.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install angtigen.
curl -L git.io/antigen > antigen.zsh

# Install Vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Backup old .zsh file.
# Make a backup of the default .zshrc file.
cp ~/.zshrc ~/.zshrc.back

# Install new .zshrc
cp .zshrc ~/.zshrc

# Install zsh theme.
cp classyTouch.zsh-theme ~/.oh-my-zsh/themes/

# Configure git.
git config --global user.name "$git_name"
git config --global user.email "$git_email"
cp ./gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Create code directory.
if [[ ! -d "$code_dir" ]]; then
    mkdir -p $HOME/code
fi

# asdf install
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# Fetch new source.
source ~/.zshrc

echo 'Done!'
