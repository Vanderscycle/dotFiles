{
  home-manager,
  catppuccin,
  username,
  ...
}:
{
  imports = [ ./${username} ];

  home-manager.users.${username} = {
    imports = [ catppuccin.homeManagerModules.catppuccin ];
    catppuccin.flavour = "mocha";
  };
}
