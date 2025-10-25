{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    languages.lua.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables lua language";
      default = true;
    };
  };
  config = lib.mkIf config.languages.lua.lsp.enable {
    home.packages = with pkgs; [
      lua
      lua-language-server
      luajitPackages.luarocks
    ];
  };
}
