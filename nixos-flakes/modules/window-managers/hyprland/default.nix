{ username, home-manager, pkgs, ... }:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in

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
  services = {
    xserver = {
      enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "${username}";
        };
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };
  home-manager.users.${username} = {
    home = {
      file = {
        ".config/hypr/hyprland.conf".source = "${dotfiles_dir}/.config/hypr/hyprland.conf";
        ".config/hypr/mocha.conf".source = "${dotfiles_dir}/.config/hypr/mocha.conf";
        ".config/hypr/start.sh".source = "${dotfiles_dir}/.config/hypr/start.sh";
      };
      packages = with pkgs; [
        swww
        xdg-desktop-portal-hyprland
        wl-clipboard
      ];
    };
  };
}
