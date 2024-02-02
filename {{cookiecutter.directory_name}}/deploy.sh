#!/bin/bash
# deploy.sh
# 2023-10-10 david.montaner@gmail.com
# deploy GCP cloud function

# The project needs to be authorized to create and use cloud functions.
# I generally create an example function in the web console and it will ask me about all permits.
#
# But you can also do it using the command line. See:
# https://getbetterdevops.io/google-cloud-functions-with-terraform/#enable-needed-google-services
#
# gcloud services enable cloudfunctions.googleapis.com
# gcloud services enable run.googleapis.com
# gcloud services enable artifactregistry.googleapis.com
# gcloud services enable cloudbuild.googleapis.com

gcloud functions deploy {{ cookiecutter.function_name }} \
       --memory=128Mi \
       --timeout=60 \
       --max-instances=1 \
       --region={{ cookiecutter.region }} \
       --project={{ cookiecutter.project }} \
       --gen2 \
       --trigger-http \
       {%- if cookiecutter.allow_unauthenticated %}
       --allow-unauthenticated \
       {%- endif %}
       --runtime=python311 \
       --entry-point={{ cookiecutter.entry_point }} \
       --source={{ cookiecutter.source }}
