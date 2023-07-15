{ config, pkgs, ... }:
let
  theme = import ../themes;
in

{
  programs = {
    autorandr = {
      enable = true;
      profiles = {
        "home" = {
          config = {
            home = {
              mode = "3440x1440";
            };
          };
        };
      };
    };
  };
}
