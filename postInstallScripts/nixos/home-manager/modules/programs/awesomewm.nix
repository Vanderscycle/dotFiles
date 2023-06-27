{ config, pkgs, ... }:

{
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
