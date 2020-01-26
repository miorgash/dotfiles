#!/bin/bash
# neologd
git clone --depth 1 git@github.com:neologd/mecab-ipadic-neologd.git ${REPOSITORIES_HOME}/mecab-ipadic-neologd
cd mecab-ipadic-neologd
./bin/install-mecab-ipadic-neologd -n

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
chsh -s /bin/zsh
