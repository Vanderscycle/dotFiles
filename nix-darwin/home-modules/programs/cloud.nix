{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    awscli.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables aws cli v2";
      default = false;
    };
    linode.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables linode cli";
      default = false;
    };
  };

  config = {
    # Merge the packages conditionally
    home.packages = with pkgs; [
      (lib.mkIf config.awscli.enable [
        ssm-session-manager-plugin
        awscli2
        rclone
      ])

      (lib.mkIf config.linode.enable [
        linode-cli
      ])
    ];
  };
}
