{
  pkgs,
  home-manager,
  username,
  ...
}:
{
  imports = [
    ./editors
    ./modern_unix.nix
  ];
}
