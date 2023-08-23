# Expedition-kube
Contains everything necessary to set up a kube cluster running the api

# /kratos
Sets up ory kratos for the app's authentication needs
Quickstart:

```sh
nu kratos/scripts/deploy-local.nu
```

# Cluster setup commands
Install cert-manager:
```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
```