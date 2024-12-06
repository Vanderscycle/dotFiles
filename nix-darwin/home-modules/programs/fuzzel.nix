{ pkgs, ... }:
{
  programs = {
    # https://codeberg.org/dnkl/fuzzel?ref=mark.stosberg.com
    fuzzel = {
      enable = true;
    };
  };
}
