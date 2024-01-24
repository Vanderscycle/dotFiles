{pkgs,...}:
{
    environment.systemPackages = with pkgs; [
    ssm-session-manager-plugin
    awscli2
  ];
}
