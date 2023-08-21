# Expedition Ory Kratos kubernetes deployment
Set google client secret: 

```sh
kubectl create secret generic expedition-kratos-google --from-literal=client-secret=<google client secret>
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