{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    kubernetes.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables kubernetes";
      default = false;
    };
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
