{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    satty
  ];
}
