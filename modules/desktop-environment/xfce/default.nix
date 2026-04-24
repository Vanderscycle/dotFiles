{ ... }:
{
  steppe.desktop-environment._.xfce = {
    nixos = {
      services = {
        xserver = {
          enable = true;
          displayManager.lightdm.enable = true;
          desktopManager.xfce.enable = true;
        };
      };
    };
  };
}
