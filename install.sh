#!/usr/bin/env bash

set -euo pipefail

sudo apt-get update
sudo apt-get install -y neovim ripgrep

mkdir -p "${HOME}/.config/nvim"

if [ ! -d "${HOME}/.config/nvim" ]; them
        cp ./init.lua "${HOME}/.config/nvim/"
fi
