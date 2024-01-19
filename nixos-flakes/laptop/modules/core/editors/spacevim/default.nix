{ pkgs, ...}:
{
  environment.systemPackages = [
    pkgs.spacevim
  ];
}
