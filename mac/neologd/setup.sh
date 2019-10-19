#!/bin/bash
git clone --depth 1 git@github.com:neologd/mecab-ipadic-neologd.git ${REPOSITORIES_HOME}/mecab-ipadic-neologd
cd mecab-ipadic-neologd
./bin/install-mecab-ipadic-neologd -n
