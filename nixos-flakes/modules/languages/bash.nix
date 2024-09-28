{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        shellcheck
        shfmt
        nodePackages.bash-language-server
      ];
    };
  };
}
