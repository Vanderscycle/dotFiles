{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
      yamlfix
      nodePackages.yaml-language-server
  ];
}
