{
  username,
  home-manager,
  pkgs,
  ...
}:

{
  home-manager.users.${username} = {
    programs = {
      git = {
        enable = true;
      };
    };
  };
}
