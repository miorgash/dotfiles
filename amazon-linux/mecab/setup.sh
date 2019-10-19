#!/bin/bash
# MeCab(https://qiita.com/yaiwase/items/8e1063d86b4a5861a743)
WORK_BASE="/usr/src"

MECAB_ROOT="${WORK_BASE}/mecab"
cd ${WORK_BASE}
sudo git clone https://github.com/taku910/mecab.git
cd ${MECAB_ROOT}/mecab
sudo ./configure --enable-utf8-only
make
make check
sudo make install

# default dictionary
cd ${MECAB_ROOT}/mecab-ipadic
# https://akamist.com/blog/archives/2578
sudo ./configure --with-charset=utf8 --with-mecab-config=/usr/local/bin/mecab-config
make
sudo make install

# neologd
sudo ln -s /usr/local/bin/mecab /usr/bin/mecab
sudo ln -s /usr/local/bin/mecab-config /usr/bin/mecab-config
cd ${MECAB_ROOT}
sudo git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
cd ${MECAB_ROOT}/mecab-ipadic-neologd
sudo ./bin/install-mecab-ipadic-neologd -n -y
