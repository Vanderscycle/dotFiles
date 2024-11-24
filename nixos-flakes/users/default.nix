{
  home-manager,
  catppuccin,
  username,
  ...
}:
{
  imports = [ ./${username} ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { };
    users.${username} = {
      imports = [ catppuccin.homeManagerModules.catppuccin ];
      catppuccin.flavor = "mocha";
    };
  };
}
