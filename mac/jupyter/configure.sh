#!/bin/bash
# Font
mkdir -p ${JUPYTER_HOME}/custom
ln -sf ${REPOS_HOME}/dotfiles/mac/configure/jupyter/custom.css ${JUPYTER_HOME}/custom/custom.css

# enable to use in pipx
python3 -m pip 
