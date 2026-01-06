#!/usr/bin/env bash

set -euo pipefail

sudo apt-get update
sudo apt-get install -y neovim ripgrep

mkdir -p "${HOME}/.config/nvim"

cp "init.lua" "${HOME}/.config/nvim/"

nvim --headless "+Lazy! sync" +qall

curl -LO "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info"
tic -x alacritty.info
