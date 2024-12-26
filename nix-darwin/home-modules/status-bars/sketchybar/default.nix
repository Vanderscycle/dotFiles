{ config, pkgs, ... }:

{
  home.file = {
    ".config/sketchybar".source = "~/Documents/dotfiles/.config/sketchybar";
  };
}
