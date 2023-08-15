#!/bin/bash
# deploy.sh
# 2023-08-14 david@insightcapital.
# deploy gcp cloud function

# The projects needs to be authorized to create and use cloud functions.
# I generally create an example function in the web console and it will ask me about all permits.

gcloud functions deploy {{ cookiecutter.function_name }} \
--project={{ cookiecutter.project }} \
--region={{ cookiecutter.region }} \
--gen2 \
--runtime=python311 \
--trigger-http \
--timeout=60 \
--memory=256MB \
--max-instances=1 \
--allow-unauthenticated \
--entry-point=entry_point_function \
--source=source
