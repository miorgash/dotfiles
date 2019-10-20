#!/bin/bash
# Extensions
pipenv run jupyter contrib nbextension install --user
pipenv run jupyter nbextensions_configurator enable --user

# Font
mkdir ${JUPYTER_CONFIG_HOME}/custom
ln -sf ${REPOSITORIES_HOME}/dotfiles/mac/jupyter/custom.css ${JUPYTER_CONFIG_HOME}/custom/custom.css
