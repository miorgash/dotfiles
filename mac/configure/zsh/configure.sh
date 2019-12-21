#!/bin/bash
# **
# path settings
# !caution!: lower settings overwrites the upper
# *

# user settings
echo '\n# user settings' >> ~/.zshenv
echo 'export REPOSITORIES_HOME="${HOME}/Repositories"' >> ~/.zshenv
echo 'export JUPYTER_CONFIG_HOME="${HOME}/.jupyter"' >> ~/.zshenv
echo 'export ENV_DIR="${HOME}/.local/venv"' >> ~/.zshenv

# for neovim etc.
echo '\n# nvim settings' >> ~/.zshenv
echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshenv
echo '\n# nvim settings' >> ~/.zshrc

# pipx
echo '\n# pipx settings' >> ~/.zshenv
echo 'export PATH=/Users/miori/.local/bin:${PATH}' >> ~/.zshenv

# **
# aliases
# *
echo 'alias vim=nvim' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
