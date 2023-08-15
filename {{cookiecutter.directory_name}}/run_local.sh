#!/bin/bash
# run_local.sh
# 2023-08-14 david.montaner@gmail.com
# run local sever

entry_point=entry_point_function
source=source
port=8080

url="http://localhost:$port"

echo $url
(sleep 6; open $url)  # open the browser in the background

SCRIPT_PATH="$(dirname "$(realpath "$0")")"
cd $SCRIPT_PATH/$source

functions-framework --target=$entry_point --port=$port --debug
