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
        # go
        gopls
        delve
        go-swag # swagger module for gofiber
      ];
    };
  };
}
