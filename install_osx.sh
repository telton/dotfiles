#!/bin/bash

# Install Homebrew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install services.
brew install zsh git curl-openssl

# Install languages.
brew install go python
