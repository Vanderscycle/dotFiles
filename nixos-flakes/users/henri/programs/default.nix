{pkgs, ...}:
{
  imports = [
    ./btop.nix
    ./flameshot.nix
  ];

  environment.systemPackages = with pkgs; [
    ytfzf
  ];
}
