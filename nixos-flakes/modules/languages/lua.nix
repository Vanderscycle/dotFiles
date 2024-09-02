{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      go = {
        enable = true;
      };
    };
    home = {
      packages = with pkgs; [
        # lua
        lua-language-server
        luajitPackages.luarocks
        luaformatter
      ];
    };
  };
}
