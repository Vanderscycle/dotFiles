{
  pkgs,
  ...
}:
let
  # https://ryantm.github.io/nixpkgs/builders/fetchers/
  themeFile = pkgs.fetchurl {
    url = "https://github.com/catppuccin/swaync/releases/download/v0.2.3/mocha.css";
    sha256 = "Hie/vDt15nGCy4XWERGy1tUIecROw17GOoasT97kIfc=";
  };
in
{
  services = {
    swaync = {
      enable = true;
      # style = builtins.readFile themeFile;
      settings = {
        font-family = "JetBrainsMono";
      };
    };
  };
}
