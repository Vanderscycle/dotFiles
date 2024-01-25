{pkgs,...}:
{
    environment.systemPackages = with pkgs; [
    linode-cli
  ];
}
