{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  options = {
    service.ssh.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables keychain";
      default = false;
    };

    service.ssh.authorizedSshKeys = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "ssh key authorized to log with";
      default = null;
    };

    service.ssh.hosts = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            hostname = lib.mkOption {
              type = lib.types.str;
              description = "The hostname or IP address of the server";
            };
            user = lib.mkOption {
              type = lib.types.str;
              description = "The username to use for the SSH connection";
              default = username;
            };
            port = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              description = "The port to use for the SSH connection";
              default = null;
            };
            identityFile = lib.mkOption {
              type = lib.types.nullOr lib.types.string;
              description = "The path to the SSH private key file";
              default = null;
            };
          };
        }
      );
      description = "A set of SSH hosts to configure";
      default = { };
    };
  };

  config = lib.mkIf config.service.ssh.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = config.service.ssh.hosts;
      addKeysToAgent = "yes";
    };

    home = {
      packages = with pkgs; [
        ssh-copy-id
      ];
    };

    # Uncomment and adjust if you want to set authorized keys for OpenSSH
    # openssh.authorizedKeys.keysFiles = lib.optionals (config.ssh.authorizedSshKeys != null) [
    #   config.ssh.authorizedSshKeys
    # ];
  };
}
