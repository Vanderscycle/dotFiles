{ pkgs, username, ... }:
{
  environment.sessionVariables = {
    FLAKE = "/home/${username}/Documents/dotFiles/nixos-flakes";
  };

  environment.systemPackages = with pkgs; [
    nh
    nvd
    nix-output-monitor
  ];
}
