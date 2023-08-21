# Expedition Ory Kratos kubernetes deployment
Set google client secret: 

```sh
 kubectl create secret generic expedition-kratos-google --from-file=expedition-kratos-google.secret.properties --dry-run=client -o yaml | kubectl apply -f -
```

Set urls:

```sh
 kubectl apply -f expedition-kratos-urls-local.yaml
```

Build and import container:
```sh
nu scripts/build-to-kube.nu
```

Create deployment:
```sh
kubectl apply -f expedition-kratos-kube.yml
```

Update image:
```sh
kubectl rollout restart deployment/expedition-kratos
```