---
title: {{ title }}
date: {{ date }}
---

# [KUST] patches

```yaml

patches:
  - target:
      kind: Deployment
      name: keycloak
    patch: |-
      - op: replace
        path: /metadata/name
        value: keycloak-non-prod
      - op: replace
        path: /metadata/annotations/vault.security.banzaicloud.io~1vault-role
        value: atreides-keycloak-non-prod
      - op: replace
        path: /spec/template/spec/containers/0/name
        value: keycloak-non-prod
      # - op: replace 
      #   path: /spec/template/spec/containers/0/command
      #   value: ["start-dev"]
      - op: replace
        path: /spec/template/spec/serviceAccountName
        value: atreides-keycloak-non-prod

```
## References

