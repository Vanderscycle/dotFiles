{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # go
        gopls
        delve
        go-swag # swagger module for gofiber
      ];
      programs = {
        go = {
          enable = true;
        };
      };
    };
  };
}
