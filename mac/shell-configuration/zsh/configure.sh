#!/bin/bash
# **
# CAUTION: lower settings overwrites the upper
# *

# user settings
echo '\n# user settings' >> ~/.zshenv
echo 'export REPOSITORIES_HOME="${HOME}/Repositories"' >> ~/.zshenv
echo 'export JUPYTER_CONFIG_HOME="${HOME}/.jupyter"' >> ~/.zshenv

# for neovim etc.
echo '\n# nvim settings' >> ~/.zshenv
echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshenv
echo '\n# nvim settings' >> ~/.zshrc
echo 'alias vim=nvim' >> ~/.zshrc

# pipx
echo '\n# pipx settings' >> ~/.zshenv
echo 'export PATH=/Users/miori/.local/bin:${PATH}' >> ~/.zshenv
