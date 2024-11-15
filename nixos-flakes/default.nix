{
  home-manager,
  catppuccin,
  hosts,
  ...
}:
{
  imports = [
    catppuccin.nixosModules.catppuccin
    home-manager.nixosModules.home-manager
    hosts.nixosModule
    {
      networking.stevenBlackHosts = {
        enable = true;
        blockFakenews = true;
        blockGambling = true;
      };
    }
    # local
    ./hosts
    ./modules
    ./users
  ];
}
