---
title: {{ title }}
date: {{ date }}
---

# [HELM] cli cmds

```bash
compile:
	helm install mentat .
debug:
	helm install --debug --dry-run mentat .
get:
	helm get manifest mentat
```

Fetch a chart (1. repo, 2. install):
* `helm repo add <chartname> <repo>`
* `helm install <name> <repo/chartname> --version <x.x.x>`

Pull the entire chart:
```bash
helm pull [chart URL | repo/chartname] [...] [flags]
```

## References

