{
  pkgs,
  home-manager,
  username,
  ...
}:
{
  imports = [
    ./devops.nix
    ./editors
    ./modern_unix.nix
    ./multimedia.nix
  ];
}
