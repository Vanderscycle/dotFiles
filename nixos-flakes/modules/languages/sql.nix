{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      go = {
        enable = true;
      };
    };
    home = {
      packages = with pkgs; [
        sqls # connect to the db
        sqlint
      ];
    };
  };
}
