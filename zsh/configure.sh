#!/bin/bash
# **
# path settings
# !caution!: lower settings overwrites the upper
# *

# user settings
echo '\n# user settings' >> ~/.zshrc
echo 'export REPOS_HOME="${HOME}/Repos"' >> ~/.zshrc
echo 'export JUPYTER_HOME="${HOME}/.jupyter"' >> ~/.zshrc

# for neovim etc.
echo '\n# nvim settings' >> ~/.zshrc
echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshrc

# pipx
echo '\n# pipx settings' >> ~/.zshrc
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.zshrc

# **
# aliases
# *
echo 'alias vim=nvim' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
echo 'alias pip=pip3' >> ~/.zshrc
