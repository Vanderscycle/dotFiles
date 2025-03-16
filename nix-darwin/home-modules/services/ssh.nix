{
  pkgs,
  lib,
  config,
  username,
  hostname,
  ...
}:
{
  options = {
    ssh.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables keychain";
      default = false;
    };

    ssh.authorizedSshKeys = lib.mkOption {
      type = lib.types.str;
      description = "ssh key authorized to log with";
      default = null;
    };
    ssh.hosts = lib.mkOption {
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
              default = username; # Default to the current user
            };
            port = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              description = "The port to use for the SSH connection";
              default = null;
            };
            identityFile = lib.mkOption {
              type = lib.types.nullOr lib.types.path;
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

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = lib.mapAttrs (name: host: {
        inherit (host)
          hostname
          user
          port
          identityFile
          ;
      }) config.ssh.hosts;

    };
    home = {
      packages = with pkgs; [
        ssh-copy-id
      ];
    };
    # openssh.authorizedKeys.keysFiles = [
    #   config.ssh.authorizedSshKeys
    # ];
  };
}
