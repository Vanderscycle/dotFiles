{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "${config.home.homeDirectory}/Documents/dotFiles";
in
{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
  ];

  options = {
    display-manager.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      description = "comes w/hyprbar";
      default = false;
    };
  };

  config = lib.mkIf config.display-manager.hyprland.enable {

    home = {
      file = {
        ".config/hypr/scripts".source =
          mkOutOfStoreSymlink "${configDir}/nix-darwin/home-modules/window-managers/hyprland/scripts";
      };
      packages = with pkgs; [
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
        wl-clipboard
        hyprcursor
        hyprpicker
        (pkgs.flameshot.overrideAttrs (oldAttrs: {
          cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
        }))
        playerctl
        wf-recorder # video recorder for wayland
        waypaper
        # screenshot when flameshot isn't working
        # cliphist
        # copyq
        grim
        slurp
      ];
    };
  };
}
