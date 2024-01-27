{ home-manager, username, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
 # unstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.config.packageOverrides = pkgs: {
   # tilt = unstable.tilt;
   # kubernetes-helm = unstable.kubernetes-helm;
   # kustomize = unstable.kustomize;
   # terragrunt = unstable.terragrunt;
   };
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # sql/db
        dbeaver
        azuredatastudio
        # k8s
        k9s
        kubernetes
        kubernetes-helm
        kustomize
        kubeseal
        kind
        tilt
        ctlptl
        argocd
        # github actions
        act
        # terraform
        terraform
        terraform-docs
        terragrunt
        # ansible
        ansible
        # backend api calls
        insomnia
        # dns
        dogdns
      ];
      file = {
        # K9s
        ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
        ".config/k9s/skin.yml".source = "${dotfiles_dir}/.config/k9s/skin.yml";
      };
    };
  };
}
      
