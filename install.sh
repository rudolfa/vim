#!/bin/bash

# This script installs vim and plugin manager of my choice.

VIMHOME=~/.vim-configs/main

mkdir -p $VINHOME

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

[ -e "$VIMHOME/vimrc" ] && die "$VIMHOME/vimrc already exists."
[ -e "~/.vim" ] && die "~/.vim already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

git clone git://github.com/rudolfa/vimrc.git "$VIMHOME"

git clone https://github.com/kristijanhusak/vim-packager $VIMHOME/pack/packager/opt/vim-packager

install -t ~/bin $VINHOME/bash/swim

echo "add follwing line into your .bashrc and restart terminal session"
echo "source $VINHOME/bash/swim-completition.bash"
