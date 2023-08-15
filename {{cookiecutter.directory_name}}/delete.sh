#!/bin/bash
# delete.sh
# 2023-08-14 david@insightcapital.
# removes gcp cloud function

gcloud functions delete  {{ cookiecutter.function_name }} \
--project={{ cookiecutter.project }} \
--region={{ cookiecutter.region }} \
--gen2
