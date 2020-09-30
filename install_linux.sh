#!/bin/bash

go_tarall="go1.15.2.linux-amd64.tar.gz"

# Install zsh.
sudo apt-get update && sudo apt-get install -y zsh curl git software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update

# Install languages.
# Python
sudo apt-get install -y python3
# Go
curl -o "https://golang.org/dl/$go_tarball"
tar xzf "$go_tarball"
sudo chown root: -R ./go
sudo mv go /usr/local
sed '/$PATH=/a export PATH=$PATH:/usr/local/go/bin' ./.zshrc
