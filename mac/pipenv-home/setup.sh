#!/bin/bash
cd $HOME
echo `pwd`
# Extensions
pipenv run jupyter contrib nbextension install --user
pipenv run jupyter nbextensions_configurator enable --user
