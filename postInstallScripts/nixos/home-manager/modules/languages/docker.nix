
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # docker
      nodePackages.dockerfile-language-server-nodejs
      hadolint
  ];
}
