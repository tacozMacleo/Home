#!/usr/bin/env bash

BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -s ${BASEDIR}/src/.bashrc.d ~/.
ln -s ${BASEDIR}/src/.vimrc ~/.
ln -s ${BASEDIR}/src/.vim ~/.
ln -s ${BASEDIR}/src/.scripts ~/.
ln -s ${BASEDIR}/src/.config/alacritty ~/.config/.
ln -s ${BASEDIR}/src/.config/kitty ~/.config/.
