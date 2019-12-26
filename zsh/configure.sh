#!/bin/bash
# **
# path settings
# !caution!: lower settings overwrites the upper
# *

# user settings
echo '\n# user settings' >> ~/.zshenv
echo 'export REPOS_HOME="${HOME}/Repos"' >> ~/.zshenv
echo 'export JUPYTER_HOME="${HOME}/.jupyter"' >> ~/.zshenv

# for neovim etc.
echo '\n# nvim settings' >> ~/.zshenv
echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshenv

# pipx
echo '\n# pipx settings' >> ~/.zshenv
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.zshenv

# **
# aliases
# *
echo 'alias vim=nvim' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
echo 'alias pip=pip3' >> ~/.zshrc
