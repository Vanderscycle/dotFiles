{
  pkgs,
  inputs,
  config,
  ...
}:

let
  trueNasFamilyUser = "smbcreds_fam"; # Define the service name as a variable
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  environment.systemPackages = [
    pkgs.sops
  ];
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/henri/.config/sops/age/keys.txt";

  # INFO: for values to be available throughout the config your must declare them
  sops.secrets."kubernetes/k3_token" = {
    owner = "proxmox";
  };
}
