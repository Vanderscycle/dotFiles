## Abstration layer

Deployment -- everything bellow is managed by k8s
ReplicaSet
Pod
Container

## cli

Create a deployment

```
kubectl create deployment {name} --image={img name}
```

docker ps but for k8s

```
kubectl get {replicaset/pod/deployment/nodes/services}
```

Get the error logs

```
kubectl describe pod {pod name}
kubectl describe {replicaset/pod/deployment/nodes/services} {name}
kubectl logs {dpl_name-replicasetID-podID}
```

Even when using the cli,k8 will autogenerate a yml config file

```
kubectl edit deployment {name}
```

Terminal session inside the container

```
kubectl exec -it {pod name} -- bin/bash
```

Deletion

```
kubectl delete {deployment/pod} {name}
```

Apply configuration for CRUD

```
kubectl apply -f {config.yml}
```

## config file

3 parts

- metadata
- specification
- status (desired/actual - etcd)

```
kubectl get deplyment {depl-name} -o yaml
```
