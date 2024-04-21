{
  home-manager,
  username,
  pkgs,
  ...
}:
{

  services.postgresql = {
    enable = true;
  };
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
