{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  nixpkgs.config.packageOverrides = pkgs: { };
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # sql/db
        dbeaver-bin
        # k8s
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
        # docker
        dive # dive into docker images
        # ansible
        ansible
        # backend api calls
        insomnia
        # dns
        dogdns
        nssmdns # for local rpi cluster
      ];
    };
  };
}
