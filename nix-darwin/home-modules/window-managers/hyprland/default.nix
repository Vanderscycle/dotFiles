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
    ./swaync.nix
  ];

  home = {
    packages = with pkgs; [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      wl-clipboard
      hyprcursor
      flameshot
      wf-recorder # video recorder for wayland
      waypaper
    ];
  };
}
