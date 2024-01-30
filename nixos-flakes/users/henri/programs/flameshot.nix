{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    flameshot
  ];
}
