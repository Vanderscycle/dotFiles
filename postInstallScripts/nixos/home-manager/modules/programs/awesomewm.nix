{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    packages = with pkgs; [
      nitrogen
    ];
    file = {
      # awesome wm
      "awesome" = {
        source = "${dotfiles_dir}/.config/awesome";
        target = "./.config/awesome";
      };
    };
  };

  xsession.windowManager = {
    awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        lain
        luafilesystem
        luarocks
        luaposix
        vicious
        dkjson
        ldbus
        lgi
      ];
    };
  };
}
