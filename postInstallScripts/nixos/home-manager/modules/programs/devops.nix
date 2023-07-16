{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    packages = with pkgs; [
      dogdns
      # k8s
      k9s
      kubernetes-helm
      kubernetes
      kustomize
      tilt
      ctlptl
      # terraform
      terraform
      terraform-docs
      # ansible
      ansible
    ];
    file = {
      # K9s
      ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
      ".config/k9s/skin.yml".source = "${dotfiles_dir}/.config/k9s/skin.yml";
    };
  };
}
    