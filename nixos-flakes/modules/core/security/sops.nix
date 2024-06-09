{
  pkgs,
  inputs,
  config,
  username,
  ...
}:

{
  environment.systemPackages = with pkgs; [ sops ];
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = "/home/${username}/Documents/dotFiles/nixos-flakes/secrets/secrets.yaml";
  # sops.defaultSopsFile = "./secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

  # map them according to the file structure
  # sops.secrets.example-key = { };
  # sops.secrets."myservice/my_subdir/my_secret" = {
  #   owner = "sometestservice";
  # };
}
