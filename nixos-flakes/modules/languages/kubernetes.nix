{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
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
  };
}
