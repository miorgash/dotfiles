#!/bin/bash
# Create virtual-env in home directory
cd $HOME
pipenv install --skip-lock
# GUI Configurator
# home の仮想環境の jupyter コマンドを使いたいだけで
# 設定自体は仮想環境をまたいで有効なはず
pipenv run jupyter nbextensions_configurator enable --user
