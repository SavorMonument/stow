#!/usr/bin/env bash

###  LazyVIM

mkdir -p ~/.config/nvim/lua/config/
mkdir -p ~/.config/nvim/lua/plugins/

stow lazyvim

###  LazyVIM

###  bashrc

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SOURCE_LINE="source $SCRIPT_DIR/bash/.bashrc"

# 3. Check if the line already exists; if not, append it
if ! grep -Fxq "$SOURCE_LINE" ~/.bashrc; then
    echo -e "\n$SOURCE_LINE" >> ~/.bashrc
fi

###  bashrc

###  scripts

stow scripts

###

### unison

mkdir -p ~/.config/systemd/user
mkdir -p ~/.local/bin
mkdir -p ~/.unison
mkdir -p ~/.local/share/remmina

stow unison

### unison
