{
  username,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    # ./swaync.nix
  ];

  home = {
    packages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      wl-clipboard
      hyprcursor
      hyprpicker
      (pkgs.flameshot.overrideAttrs (oldAttrs: {
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
      }))
      wf-recorder # video recorder for wayland
      waypaper
      # screenshot since flameshot isn't working
      cliphist
      copyq
      grim
      slurp
    ];
  };
}
