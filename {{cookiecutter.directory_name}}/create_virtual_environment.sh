#!/bin/bash
# create_virtual_environment.sh
# 2023-11-20 david.montaner@gmail.com
# set up virtual environment for local development

source="src"

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
cd $SCRIPT_PATH

virtualenv venv

source venv/bin/activate

pip install -U pip
pip install -r $source/requirements.txt
