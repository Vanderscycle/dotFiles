{
  pkgs,
  inputs,
  config,
  username,
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

    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
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

      # TruNas SMB access
      "home-server/rice/password" = {
        owner = "root";
      };

      "home-server/rice/user" = {
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
