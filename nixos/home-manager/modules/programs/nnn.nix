{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    sxiv
  ];
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      p = "~/Pictures";
      v = "~/Videos";
      c = "~/.config";
      n = "/mnt";
      w = "~/Documents/house operto";
    };
  };
}
