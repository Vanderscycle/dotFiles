{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    packages = with pkgs; [
      dogdns
      k9s
      kubernetes-helm
      kubernetes
      ansible
      kustomize
      tilt
      terraform
      terraform-docs
    ];
    file = {
      # K9s
      ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
      ".config/k9s/skin.yml".source = "${dotfiles_dir}/.config/k9s/skin.yml";
    };
  };
}
    