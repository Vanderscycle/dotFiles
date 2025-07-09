{
  meta,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  # if you change the secret strucutre you must first create the new secret and then rebuild and then change its reference in the config
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${meta.username}/.config/sops/age/keys.txt";
    secrets = {
      # factorio
      "factorio/game-password" = {
        owner = meta.username;
      };
      "factorio/token" = {
        owner = meta.username;
      };
      "factorio/admin" = {
        owner = meta.username;
      };
      # paperless
      "paperless/admin/password" = {
        owner = meta.username;
      };
      "paperless/admin/username" = {
        owner = meta.username;
      };
      "paperless/admin/email" = {
        owner = meta.username;
      };
      # smb root user
      "home-server/rice/password" = {
        owner = "root";
      };
      "home-server/rice/user" = {
        owner = "root";
      };
      # docker
      "docker/homarr/enc_key" = {
        owner = "root";
      };
      # smb systemd user
      "home-server/systemd/password" = {
        owner = meta.username;
      };
      "home-server/systemd/user" = {
        owner = meta.username;
      };
      # nextcloud
      "nextcloud/admin/password" = {
        owner = "root";
      };
    };
  };
  systemd.services."smbcreds_fam_root" = {
    script = ''
      echo "user=$(cat ${config.sops.secrets."home-server/rice/user".path})" > /root/smbcreds_fam
      echo "password=$(cat ${config.sops.secrets."home-server/rice/password".path})" >> /root/smbcreds_fam
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      WorkingDirectory = "/root/";
    };
    # Make it run immediately after each system rebuild
    wantedBy = [ "multi-user.target" ];
  };

  # TODO: change the user
  systemd.services."smbcreds_fam_general" = {
    script = ''
      echo "user=$(cat ${
        config.sops.secrets."home-server/systemd/user".path
      })" > "/home/${meta.username}/smbcreds_fam_user"
      echo "password=$(cat ${
        config.sops.secrets."home-server/systemd/password".path
      })" >> "/home/${meta.username}/smbcreds_fam_user"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = meta.username;
      WorkingDirectory = "/home/${meta.username}";
    };
    # Make it run immediately after each system rebuild
    wantedBy = [ "multi-user.target" ];
  };
}
