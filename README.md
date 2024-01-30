# GCP Cloud Function Template

Simple template for quick deployment of GCP Cloud Functions.

(There is a multipage version commented)

## Usage

### Create a new function directory from the template

    pip install cookiecutter

    cookiecutter https://github.com/dmontaner/gcp_cloud_function_template.git

### Develop locally
    
    cd gcp_cloud_function_1  # your created folder here
    virtualenv venv
    source venv/bin/activate
    pip install -r src/requirements.txt
    deactivate

    ./run_local_server.sh

### Deploy to GCP

The project where the function is to be deployed needs to have the right permits.
Usually I just create a default function within the project web console
so that GCP asks me for all those permits and sets them for the project.

Then:

    bash deploy.sh 

### Test the cloud function

    python tests/test_cloud_function.py

### Delete function fromGCP

    bash delete.sh 
