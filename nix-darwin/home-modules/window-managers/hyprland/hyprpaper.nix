{
  pkgs,
  ...
}:
{
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "~/Pictures/switch.png"
        ];
        wallpaper = [
          " , ~/Pictures/switch.png"
        ];
      };
    };
  };
}
