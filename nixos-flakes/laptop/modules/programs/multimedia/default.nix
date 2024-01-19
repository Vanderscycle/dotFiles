{ home-manager, username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        spotify
        discord
      ];
    };
  }
}
