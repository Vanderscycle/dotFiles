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
      "emacs/forge/gh_api" = {
        owner = "henri";
      };
      "emacs/llm/closedai" = {
        owner = "henri";
      };
      # INFO: for values to be available throughout the config your must declare them
      "yubico/u2f_keys" = {
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

  systemd.services."authinfo" = {
    script = ''
      echo "$(cat ${config.sops.secrets."emacs/forge/gh_api".path})" > /home/henri/.authinfo
      echo "$(cat ${config.sops.secrets."emacs/llm/closedai".path})" >> /home/henri/.authinfo
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "henri";
      WorkingDirectory = "/home/henri/";
    };
    # Make it run immediately after each system rebuild
    wantedBy = [ "multi-user.target" ];
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
