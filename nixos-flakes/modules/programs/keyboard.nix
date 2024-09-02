{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wally-cli
  ];
}
