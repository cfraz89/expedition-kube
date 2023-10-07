#!/bin/sh
cd env
#cue cmd -t env=local -t secrets=expedition apply
cue export --out yaml -e config.local -e secret.expedition | kubectl apply -f -