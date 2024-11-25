{
  home-manager,
  catppuccin,
  ...
}:
{
  imports = [
    home-manager.nixosModules.home-manager
    # local
    ./hosts
    ./modules
    ./users
  ];
}
