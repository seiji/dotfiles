#!/usr/bin/env python
# -*- coding: utf-8 -*-

def response(context, flow):
    if '/api/boot/' not in flow.request.path:
        return

    flow.response.status_code = 500
