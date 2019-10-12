#!/bin/bash
echo 'export REPOSITORIES_HOME="${HOME}/Repositories"' >> ~/.zshenv
echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshenv
echo 'export JUPYTER_CONFIG_HOME="${HOME}/.jupyter"' >> ~/.zshenv
echo 'export PATH="${HOME}/WordVector:$PATH"' >> ~/.zshenv
echo 'alias vim=nvim' >> ~/.zshrc
