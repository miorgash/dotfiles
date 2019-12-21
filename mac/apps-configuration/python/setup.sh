#!/bin/bash
# ln -sf ${REPOSITORIES_HOME}/dotfiles/mac/python/Pipfile ${HOME}/Pipfile

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
echo -e 'if command -v pyenv 2>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshenv

# install poetry
url -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
