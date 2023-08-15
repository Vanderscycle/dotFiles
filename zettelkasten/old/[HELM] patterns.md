---
title: {{ title }}
date: {{ date }}
---

# [HELM] patterns
To install a service like [nginx](https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx)
```bash
helm install my-ingress-nginx ingress-nginx/ingress-nginx --version <version> --namespace <namespace> --create-namespace
```

## References

