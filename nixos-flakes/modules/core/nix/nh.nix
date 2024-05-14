{ pkgs, ... }:
{
  environment.sessionVariables = {
    FLAKE = "/home/henri/Documents/dotFiles/nixos-flakes";
  };

  environment.systemPackages = with pkgs; [ nh ];
}
