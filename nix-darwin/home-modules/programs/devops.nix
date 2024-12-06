{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # sql/db
      # beekeeper-studio # not supported on aarch64-darwin
      # mysql-workbench # not supported on aarch64-darwin
      # backend api calls
      # insomnia # not supported on aarch64-darwin
      # backend api calls
      # dns
      dogdns
    ];
  };
}
