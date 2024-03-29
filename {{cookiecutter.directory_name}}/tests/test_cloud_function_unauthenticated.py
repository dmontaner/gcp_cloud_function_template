# test_cloud_function_unauthenticated.py
# 2023-10-10 david.montaner@gmail.com
# testing the cloud function

import requests

URL = "https://{{ cookiecutter.region }}-{{ cookiecutter.project }}.cloudfunctions.net/{{ cookiecutter.function_name }}"
# URL = "http://127.0.0.1:{{ cookiecutter.port }}"


# GET
res = requests.get(URL)
assert not res.ok
assert res.status_code == 400
assert res.text == 'Bad Request: `name` parameter was expected.'

res = requests.get(URL + "?name=David")
assert res.ok
assert res.status_code == 200
assert res.text == "Hello David!"


# POST
res = requests.post(URL)
assert not res.ok
assert res.status_code == 400
assert res.text == 'Bad Request: `name` parameter was expected.'

res = requests.post(URL, json={"name": "David"})
assert res.ok
assert res.text == "Hello David!"
