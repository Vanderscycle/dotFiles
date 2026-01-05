{
  config,
  ...
}:

let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "${config.home.homeDirectory}/Documents/dotFiles";
in
{

  home = {
    file = {
      "Pictures/wallpapers".source = mkOutOfStoreSymlink "${configDir}/nix-darwin/wallpapers";
    };
  };
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${config.home.homeDirectory}/Pictures/wallpapers/forest_mountain.jpg"
        ];
        wallpaper = [
          ",${config.home.homeDirectory}/Pictures/wallpapers/forest_mountain.jpg"
        ];
        # Optional: Enable splash text over the wallpaper
        splash = false;
      };
    };
  };
}
