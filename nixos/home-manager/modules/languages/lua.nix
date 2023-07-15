{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # lua
    lua-language-server
    luajitPackages.luarocks
    luaformatter
  ];
}
