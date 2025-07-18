{
  pkgs,
  inputs,
  config,
  meta,
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
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${meta.username}/.config/sops/age/keys.txt";
    secrets = {
      # Maggit Forge
      # TruNas SMB access
      "home-server/rice/password" = {
        owner = "root";
      };

      "home-server/rice/user" = {
        owner = "root";
      };
    };
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
