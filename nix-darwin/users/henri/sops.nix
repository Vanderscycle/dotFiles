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
  sops.secrets."emacs/forge/gh_api" = {
    owner = "henri";
  };
  systemd.services."authinfo" = {
    script = ''
      echo "$(cat ${config.sops.secrets."emacs/forge/gh_api".path})" > /home/henri/.authinfo
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "henri";
      WorkingDirectory = "/home/henri/";
    };
    # Make it run immediately after each system rebuild
    wantedBy = [ "multi-user.target" ];
  };

  sops.secrets."home-server/rice/password" = {
    owner = "root";
  };

  sops.secrets."home-server/rice/user" = {
    owner = "root";
  };

  systemd.services."smbcreds_fam" = {
    script = ''
      echo "user=$(cat ${config.sops.secrets."home-server/rice/user".path})" > /root/${trueNasFamilyUser}
      echo "password=$(cat ${
        config.sops.secrets."home-server/rice/password".path
      })" >> /root/${trueNasFamilyUser}
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      WorkingDirectory = "/root/";
    };
    # Make it run immediately after each system rebuild
    wantedBy = [ "multi-user.target" ];
  };
}
