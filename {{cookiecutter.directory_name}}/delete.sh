#!/bin/bash
# delete.sh
# 2023-10-10 david.montaner@gmail.com
# removes GCP cloud function

gcloud functions delete  {{ cookiecutter.function_name }} \
--project={{ cookiecutter.project }} \
--region={{ cookiecutter.region }} \
--gen2
