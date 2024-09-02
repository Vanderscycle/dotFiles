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

        # docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint
      ];
    };
  };
}
