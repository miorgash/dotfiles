#!/bin/bash
mkdir -p ${HOME}/.venv
python3 -m venv ${HOME}/.venv/default
source ${HOME}/.venv/default/bin/activate
pip3 install -r requirements.txt
