#!/bin/bash

# Install zsh.
sudo apt-get update && sudo apt-get install -y zsh curl git software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update

# Install languages.
# Python
sudo apt-get install -y python3
