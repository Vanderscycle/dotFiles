{
  username,
  pkgs,
  inputs,
  config,
  ...
}:
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

  sops.secrets."k3_token" = {
    owner = "cloud";
  };
}
