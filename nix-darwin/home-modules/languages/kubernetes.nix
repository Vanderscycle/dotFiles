{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      # k8s
      kubernetes
      kubernetes-helm
      kustomize
      kubeseal
      kind
      tilt
      ctlptl
      argocd
    ];
  };
}
