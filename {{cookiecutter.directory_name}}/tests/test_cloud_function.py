# test_cloud_function.py
# 2023-10-10 david.montaner@gmail.com
# testing the cloud function

import requests

# GET
URL = "https://{{ cookiecutter.region }}-{{ cookiecutter.project }}.cloudfunctions.net/{{ cookiecutter.function_name }}"
# URL = "http://127.0.0.1:{{ cookiecutter.port }}"

# GET
res = requests.get(URL)
assert res.ok
assert res.text == "Hello World!"

res = requests.get(URL + "?name=David")
assert res.ok
assert res.text == "Hello David!"


# POST
res = requests.post(URL)
assert res.ok
assert res.text == "Hello World!"

res = requests.post(URL, json={"name": "David"})
assert res.ok
assert res.text == "Hello David!"
