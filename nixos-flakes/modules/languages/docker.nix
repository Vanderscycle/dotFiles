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
        dive
        # docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint
      ];
    };
  };
}
