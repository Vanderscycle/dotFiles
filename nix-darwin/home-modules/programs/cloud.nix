{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    awscli.enable = lib.mkEnableOption "enables aws cli v2";
    linode.enable = lib.mkEnableOption "enables linode cli";
  };

  config = {
    # Merge the packages conditionally
    home.packages =
      with pkgs;
      [
        (lib.mkIf config.awscli.enable [
          ssm-session-manager-plugin
          awscli2
          rclone
        ])

        (lib.mkIf config.linode.enable [
          linode-cli
        ])
      ]
      // [ ];
  };
}
