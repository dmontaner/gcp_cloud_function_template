# main.py
# 2023-10-30 david.montaner@gmail.com
# main entry function

import functions_framework
from flask import render_template

import logging
logging.basicConfig(level=logging.DEBUG)


@functions_framework.http
def {{ cookiecutter.entry_point }}(request):

    request_json = request.get_json(silent=True)
    request_args = request.args

    logging.debug(f"request_json: {request_json}")
    logging.debug(f"request_args: {request_args}")

    # BASE CODE
    if request_json and "name" in request_json:
        name = request_json["name"]
    elif request_args and "name" in request_args:
        name = request_args["name"]
    else:
        # name = "World"
        logging.error(f"Bad Request /// JSON: {request_json} /// ARGS: {request_args}")
        return "Bad Request: `name` parameter was expected.", 400

    logging.info('Starting main function')
    logging.debug(f'name: {name}')

    return f"Hello {name}!"

    # # MULTIPAGE CODE

    # # parse arguments
    # if "page" in request.args.keys():
    #     page = request.args["page"]
    # else:
    #     page = "index"

    # # render pages
    # if page == "index":
    #     return render_template("index.html", content=[1, 2, 3])
    # elif page == "2":
    #     return render_template("page2.html", content=[10, 20, 30])
    # else:
    #     return render_template("page_not_found.html", page=page)
