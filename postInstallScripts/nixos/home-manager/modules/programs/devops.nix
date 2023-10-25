{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    packages = with pkgs; [
      # sql/db
      dbeaver
      dogdns
      azuredatastudio
      # k8s
      k9s
      kubernetes-helm
      kubernetes
      kustomize
      kind
      tilt
      ctlptl
      # terraform
      terraform
      terraform-docs
      terragrunt
      # ansible
      ansible
      # backend api calls
      insomnia
    ];
    file = {
      # K9s
      ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
      ".config/k9s/skin.yml".source = "${dotfiles_dir}/.config/k9s/skin.yml";
    };
  };
}
    