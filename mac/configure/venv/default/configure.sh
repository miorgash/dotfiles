#!/bin/bash
mkdir .venv
cd .venv
python -m venv default
source ~/.venv/default/bin/activate
pip install -r requirements.txt
