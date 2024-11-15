{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs =
      {
      };
    home = {
      packages =
        with pkgs;
        [
        ];
    };
  };
}
