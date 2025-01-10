{
  pkgs,
  inputs,
  username,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModule.sops
  ];
  environment.systemPackages = [
    pkgs.sops
  ];
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/User/${username}/.config/sops/age/keys.txt";

  sops.secrets."knak/email" = {
    owner = username;
  };
  sops.secrets."knak/git/userName" = {
    owner = username;
  };
  sops.secrets."knak/git/keyName" = {
    owner = username;
  };
}
