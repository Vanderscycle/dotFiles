{ pkgs, username, ... }:
{
  virtualisation = {

    virtualbox = {
      host = {
        enableExtensionPack = true;
        enable = true;
      };
      guest = {
        draganddrop = true;
        enable = true;
      };
    };
  };
}
