#!/bin/bash

# Install zsh.
sudo apt-get update && sudo apt-get install zsh -y

# Install oh-my-zsh.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
