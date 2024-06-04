{ pkgs, hostname, ... }:
{
  environment.sessionVariables = {
    FLAKE = "/home/${hostname}/Documents/dotFiles/nixos-flakes";
  };

  environment.systemPackages = with pkgs; [
    nh
    nvd
    nix-output-monitor
  ];
}
