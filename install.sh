#!/bin/bash

# This script installs vimrc and plugin manager of my choice.

VIMHOME=~/.vim

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

ln -s $VINHOME/vimrc ~/.vimrc
