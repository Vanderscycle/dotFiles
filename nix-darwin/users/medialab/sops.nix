{
  pkgs,
  inputs,
  config,
  meta,
  ...
}:
let
  synologyUser = "synology";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  environment.systemPackages = [
    pkgs.sops
  ];
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${meta.username}/.config/sops/age/keys.txt";
    secrets = {
      # Maggit Forge
      # TruNas SMB access
      "home-server/wifi/password" = {
        owner = "root";
      };

      # Synology SMB access
      "home-server/synology/password" = {
        owner = "root";
      };

      "home-server/synology/user" = {
        owner = "root";
      };
    };
  };

  systemd.services."smbcreds_fam" = {
    script = ''
      echo "user=$(cat ${config.sops.secrets."home-server/synology/user".path})" > /root/${synologyUser}
      echo "password=$(cat ${
        config.sops.secrets."home-server/synology/password".path
      })" >> /root/${synologyUser}
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
