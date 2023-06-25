{ config, pkgs, ... }:

{
    xsession.windowManager = {
        awesome = {
            luaModules = with pkgs.luaPackages; [
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