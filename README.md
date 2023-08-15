# GCP Cloud Function Template

Simple "multipage" template for quick deployment of GCP Cloud Functions.

## Usage

### Create a new function directory from the template

    pip install cookiecutter
    cookiecutter https://github.com/dmontaner/gcp_cloud_function_template.git

### Develop locally
    
    cd gcp_cloud_function_1  # your created folder here
    pip install -r source/requirements.txt
    bash run_local.sh 

### Deploy to GCP

The project where the function is to be deployed needs to have the right permits.
Usually I just create a default function within the project web console
so that GCP asks me for all those permits and sets them for the project.

Then:

    bash deploy.sh 

### Delete function fromGCP

    bash delete.sh 
