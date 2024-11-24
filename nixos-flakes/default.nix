{
  home-manager,
  catppuccin,
  ...
}:
{
  imports = [
    # catppuccin.nixosModules.catppuccin
    home-manager.nixosModules.home-manager
    # local
    ./hosts
    ./modules
    ./users
  ];
}
