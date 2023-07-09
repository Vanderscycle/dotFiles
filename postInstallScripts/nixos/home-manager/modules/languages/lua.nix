{ config, pkgs, ... }:
{

  packages = with pkgs; [
    # lua
    lua-language-server
    luajitPackages.luarocks
    luaformatter
  ];
}
