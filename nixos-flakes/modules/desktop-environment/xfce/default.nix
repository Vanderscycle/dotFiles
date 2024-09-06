{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.xfce = {
        enableScreensaver = false;
        enable = true;
      };
    };
  };
}
