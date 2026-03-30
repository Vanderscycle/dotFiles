{
  lib,
  meta,
  config,
  ...
}:
# xfce + lightdm
{

  options = {
    display-manager.xfce.enable = lib.mkOption {
      type = lib.types.bool;
      description = "xfce the goat";
      default = false;
    };

    display-manager.lightdm.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Lightdm";
      default = false;
    };

    display-manager.autologin.enable = lib.mkOption {
      type = lib.types.bool;
      description = "skips the login screen";
      default = false;
    };
  };
  config = {
    services = {
      displayManager = {
        autoLogin = {
          enable = lib.mkIf config.display-manager.autologin.enable;
          user = "${meta.username}";
        };
      };
      xserver = {
        enable = true;
        displayManager.lightdm.enable = lib.mkIf config.display-manager.lightdm.enable;
        desktopManager.xfce.enable = lib.mkIf config.display-manager.xfce.enable;
      };
    };
  };
}
