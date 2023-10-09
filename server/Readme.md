# Expedition Ory Kratos kubernetes deployment
# Quick setup + deploy for local dev
```sh
nu scripts/deploy-local.nu
```

## Individual commands
Build container image and import to k8s:
```sh
nu scripts/build-to-kube.nu
```

Set google client secret: 

```sh
 kubectl apply -f config/kube/kratos-google.secret.yaml
```

Set urls:

```sh
 kubectl apply -f config/kube/kratos-config-local.yaml
```
Create deployment:
```sh
kubectl apply -f config/kube/expedition-kratos-kube.yaml
```

Rollout restart deployment:
```sh
kubectl rollout restart deployment/expedition-kratos
```
