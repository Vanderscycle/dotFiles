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
        shellcheck
        nodePackages.bash-language-server
      ];
    };
  };
}
