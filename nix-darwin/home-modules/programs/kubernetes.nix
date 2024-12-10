{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    kubernetes.enable = lib.mkEnableOption "enables kubernetes";
  };
  config = lib.mkIf config.kubernetes.enable {
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
