#!/bin/sh
cd env
#cue cmd -t env=local -t secrets=local apply
cue export --out yaml -e secret.local | kubectl apply -f -