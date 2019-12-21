#!/bin/bash
mkdir -p ${XDG_CONFIG_HOME}/nvim/colors
ln -s ${REPOSITORIES_HOME}/dotfiles/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
git clone https://github.com/cocopon/iceberg.vim/ ${REPOSITORIES_HOME}/iceberg.vim
cp ${REPOSITORIES_HOME}/iceberg.vim/colors/iceberg.vim ${XDG_CONFIG_HOME}/nvim/colors/iceberg.vim

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
