{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # java
    jre8
  ];
}
