{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ssm-session-manager-plugin
    awscli2
    rclone
  ];
}
