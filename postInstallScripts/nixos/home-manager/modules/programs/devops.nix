{ config, pkgs, ... }:
{
home.packages = with pkgs; [
      dogdns
      k9s
      kubernetes-helm
      kubernetes
      ansible
      kustomize
      tilt
      terraform
];
}
    