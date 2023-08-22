# Expedition Ory Kratos kubernetes deployment
Set google client secret: 

```sh
 kubectl apply -f kratos-google.secret.yaml
```

Set urls:

```sh
 kubectl apply -f kratos-config-local.yaml
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