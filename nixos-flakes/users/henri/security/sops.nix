{
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
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/henri/.config/sops/age/keys.txt";
  sops.secrets."emacs/forge/gh_api" = {
    owner = "henri";
  };
  systemd.services."authinfo" = {
    script = ''
      echo "$(cat ${config.sops.secrets."emacs/forge/gh_api".path})" > /home/henri/.authinfo
    '';
    serviceConfig = {
      User = "henri";
      WorkingDirectory = "/home/henri/";
    };
  };
}
