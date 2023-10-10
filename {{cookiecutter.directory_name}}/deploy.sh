#!/bin/bash
# deploy.sh
# 2023-10-10 david.montaner@gmail.com
# # deploy GCP cloud function

# The project needs to be authorized to create and use cloud functions.
# I generally create an example function in the web console and it will ask me about all permits.

gcloud functions deploy {{ cookiecutter.function_name }} \
       --memory=128Mi \
       --timeout=60 \
       --max-instances=1 \
       --region={{ cookiecutter.region }} \
       --project={{ cookiecutter.project }} \
       --gen2 \
       --trigger-http \
       --allow-unauthenticated \
       --runtime=python311 \
       --entry-point={{ cookiecutter.entry_point }} \
       --source={{ cookiecutter.entry_point }}
