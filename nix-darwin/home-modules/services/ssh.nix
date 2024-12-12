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
  };

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
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
