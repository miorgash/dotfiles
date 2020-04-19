#!/bin/bash
# **
# path settings
# !caution!: lower settings overwrites the upper
# *

# for neovim etc.
echo '\n# nvim settings' >> ~/.zshrc
echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshrc

# **
# aliases
# *
echo '\n# alias' >> ~/.zshrc
echo 'alias vim=nvim' >> ~/.zshrc

