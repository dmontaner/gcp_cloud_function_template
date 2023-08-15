# main.py
# 2023-08-14 david.montaner@gmail.com
# main entry function

import functions_framework
from flask import render_template


@functions_framework.http
def entry_point_function(request):
    print('ARGUMENTS', request.args, flush=True)

    # PARSE ARGUMENTS
    if 'page' in request.args.keys():
        page = request.args['page']
    else:
        page = 'index'

    # RENDER PAGES
    if page == 'index':
        return render_template("index.html", content=[1, 2, 3])
    elif page == '2':
        return render_template("page2.html", content=[10, 20, 30])
    else:
        return render_template("page_not_found.html", page=page)
