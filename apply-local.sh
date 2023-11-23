#!/bin/sh
timoni apply expedition-nominatim nominatim
timoni apply expedition-kratos kratos --values env/kratos-local.cue --values env/kratos-google.secret.cue
timoni apply expedition-backend backend --values env/backend.secret.cue
timoni apply expedition-web web --values env/web.secret.cue