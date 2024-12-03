{ pkgs, ... }:
{
  packages = with pkgs; [
    #yaml
    nodePackages.yaml-language-server # npm i -g yaml-language-server
  ];
}
