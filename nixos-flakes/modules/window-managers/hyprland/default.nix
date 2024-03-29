{ username, home-manager, pkgs, ... }:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # https://github.com/NixOS/nixpkgs/issues/157101
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
  };
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
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-wlr # If you're using a wlroots-based compositor
    # Other relevant applications
  ];
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox, similar for other apps
    # For Electron apps, you might need to set these in the application launch options or scripts
  };
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "paschoal";
        };
      };
    };
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
      sessionVariables = {
        XDG_CURRENT_DESKTOP = "Sway";
        QT_QPA_PLATFORM = "wayland";
        CLUTTER_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        MOZ_ENABLE_WAYLAND = 1;
        MOZ_WEBRENDER = 1;
        XDG_SESSION_TYPE = "wayland";

      };
      packages = with pkgs; [
        swww
        xdg-desktop-portal-hyprland
        wl-clipboard
      ];
    };
  };
}
