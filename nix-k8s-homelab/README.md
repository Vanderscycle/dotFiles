# Infrastructure

Infrastructure as Code (IaC) required to sustain vancycles-industries

## spin new instance

0. import the kubeconfig.yaml file into $HOME/.kube/infrastructure-kubeconfig.yaml
set -xg KUBECONFIG $HOME/.kube/infrastructure-kubeconfig.yaml
1. cd into ./charts/argocd/overlays/prod/
2. kustomize build --load-restrictor LoadRestrictionsNone --enable-helm . | k apply -f -
3. change the password https://argo-cd.readthedocs.io/en/stable/getting_started/
4. add the github repo
5. fetch cluster kubeseal perms
```
 kubectl get secret -n kube-system -l sealedsecrets.bitnami.com/sealed-secrets-key -o jsonpath="{.items[*].data['tls\.crt']}" | base64 --decode > kubeseal-public.pem
```
6. reseal all the secrets :
```
kubeseal --format yaml --cert='../../../../../kubeseal-public.pem' < secret.yaml > sealed-secret.yaml -n <namespace>
```

##
- TODO: add dns records for resend
- TODO: add encryptions for gitops secrets and use ssm (aws)
- TODO: Create a new protonmail address for vancycles-industries
- TODO: create new linode acct to support vancycles-industries infra
