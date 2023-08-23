#!/bin/env nu
cd $env.FILE_PWD
./build-to-kube.nu
kubectl apply -f ../config/kube/google.secret.yaml
kubectl apply -f ../config/kube/config-local.yaml
kubectl apply -f ../config/kube/deployment.yaml
kubectl apply -f ../config/kube/service.yaml
kubectl apply -f ../config/kube/ingress.yaml