{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.awscli.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables aws cli v2";
      default = false;
    };
    program.linode.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables linode cli";
      default = false;
    };
  };

  config = {
    # Merge the packages conditionally
    home.packages =
      with pkgs;
      (lib.optionals config.program.awscli.enable [
        ssm-session-manager-plugin
        awscli2
        aws-sam-cli
        rclone
      ])
      ++ (lib.optionals config.program.linode.enable [
        linode-cli
      ]);
  };
}
