#!/bin/bash
# run_local_server.sh
# 2023-10-10 david.montaner@gmail.com
# run GCP cloud function in local server

port={{ cookiecutter.port }}
source="{{ cookiecutter.source }}"
entry_point={{ cookiecutter.entry_point }}

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
cd $SCRIPT_PATH

if [ -d "venv" ]
then
    source "$SCRIPT_PATH/venv/bin/activate"
fi

echo "PYTHON EXE: $(which python3)"

url="http://localhost:$port"
echo "SERVER: $url"

cd $source  # because the --source parameter in functions-framework does not work for me!!!
functions-framework --target=$entry_point --port=$port --debug
