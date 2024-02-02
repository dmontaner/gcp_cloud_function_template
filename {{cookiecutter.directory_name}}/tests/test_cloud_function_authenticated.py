# test_cloud_function_authenticated.py
# 2023-10-10 david.montaner@gmail.com
# testing the cloud function with oauth2

import requests

import google.auth.transport.requests
from google.oauth2.service_account import IDTokenCredentials

# The service account JSON key file to use to create the Identity Token
keyfile = "service_account_key.json"

URL = "https://{{ cookiecutter.region }}-{{ cookiecutter.project }}.cloudfunctions.net/{{ cookiecutter.function_name }}"


# ACTIVATE CREDENTIALS
credentials = IDTokenCredentials.from_service_account_file(
    filename=keyfile,
    target_audience=URL,
)
request = google.auth.transport.requests.Request()
credentials.refresh(request)


headers = {'Authorization': 'Bearer ' + credentials.token}


# GET
res = requests.get(URL, headers=headers)
assert res.ok
assert res.text == "Hello World!"

res = requests.get(URL + "?name=David", headers=headers)
assert res.ok
assert res.text == "Hello David!"


# POST
res = requests.post(URL, headers=headers)
assert res.ok
assert res.text == "Hello World!"

res = requests.post(URL, json={"name": "David"}, headers=headers)
assert res.ok
assert res.text == "Hello David!"
