---
title: {{ title }}
date: {{ date }}
---

# [HELM] Basics
Enable debug mode
`$HELM_DEBUG`

verbose output: `--debug`
`helm install --dry-run --debug`

## Helm repo

The main lookup is at `artifacthub.com` but there's a central location 

## Helm components

* values.yaml
* templates/
* Chart.yaml
```
.
├── Chart.yaml
├── charts
├── makefile
├── templates
│   └── configmap.yaml
└── values.yaml

```

## Helm 2 vs 3

Ensure that the `apiVersion: v2` which refers to Helm 3 and supports `type` and `dependencies`. Types either application or library.

## Cli
Charts are a collection of files. The reason why there's a release-name is so that more than one deployment of the same helm-chart can be done. This way we can upgrade/rollback one release without impacting the other.
```
helm install [release-name][chart-name]

helm install my-first-site bitnami/wordpress

helm install my-second-site bitnami/wordpress
```
Upgrade/removal
```
helm upgrade/rollback [release][chart]
helm uninstall [release]

```

To manage the charts, you can also add high quality repos like `bitnami` or `hashicorp` and the search by repo
 

```
helm repo add [name][repo] 
helm repo [upgrade/rollback][chat name]
helm search [hub/repo][name] 
helm repo ls # list avail repo
```

## Customize install

The helm install command doesn't apply any changes by default and so there's 2 way to customize a charty: `inline` and `custom_values.yaml`
```
# inline
helm install --set nameOfParameter=<nameOfArgument> [my-release][chart]
# values
helm install --values custom-values.yaml [release-name][chart]
```
## 


Creates a directory of the same name as the chart 
```
# step 1
helm pull --untar [chart]
# step 2
helm install [release-name] ./chart # path to the local chart dir
```

## References

