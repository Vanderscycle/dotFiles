{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.kubernetes.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables kubernetes";
      default = false;
    };

    program.kubernetes.kubeconfig = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "The default kubeconfig";
      default = { };
    };
  };

  config = lib.mkIf config.program.kubernetes.enable {
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
        kubectx # easy contect changing
      ];
      sessionVariables = config.program.kubernetes.kubeconfig;
    };
  };
}
