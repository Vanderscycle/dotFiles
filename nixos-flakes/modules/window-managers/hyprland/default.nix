{ pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
    };
    xwayland = {
      enable = true;
    };
    sway = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  environment.systemPackages = with pkgs; [
    #   xdg-desktop-portal
    xdg-desktop-portal-hyprland
    #   xdg-desktop-portal-wlr # If you're using a wlroots-based compositor
    #   # Other relevant applications
  ];
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox, similar for other apps
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    #   # For Electron apps, you might need to set these in the application launch options or scripts
  };
}
