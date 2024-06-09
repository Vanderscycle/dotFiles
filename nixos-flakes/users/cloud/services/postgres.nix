{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.postgresql ];
}
