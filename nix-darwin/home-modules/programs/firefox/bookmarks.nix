{
  pkgs,
  inputs,
  system ? builtins.currentSystem,
  username,
  lib,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles.${username} = {
      bookmarks = [
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
        {
          name = "home-manager";
          tags = [
            "docs"
            "nixos"
          ];
          keyword = "docs";
          url = "https://nix-community.github.io/home-manager/options.xhtml";
        }
        {
          name = "nix packages";
          tags = [ "nixos" ];
          keyword = "nixos";
          url = "https://search.nixos.org/packages";
        }
        {
          name = "GitHub";
          tags = [ "coding" ];
          keyword = "coding";
          url = "https://github.com/Vanderscycle";
        }
        {
          name = "yt-dreamsOfAutonomy";
          tags = [
            "yt"
            "coding"
          ];
          keyword = "yt";
          url = "https://www.youtube.com/@dreamsofautonomy";
        }
        {
          name = "yt-OpenWrt"; # OpenWrt
          tags = [
            "yt"
            "openWrt"
          ];
          keyword = "yt";
          url = "https://www.youtube.com/@OneMarcFifty";
        }
        {
          name = "yt-wrt1900ac-openwrt-install";
          tags = [
            "yt"
            "openWrt"
            "Linksys wrt1900ac"
          ];
          keyword = "yt";
          url = "https://www.youtube.com/watch?v=GVjIOzErKcc";
        }
        {
          name = "proxmox scripts";
          tags = [
            "proxmox"
            "homelab"
          ];
          keyword = "homelab";
          url = "https://community-scripts.github.io/ProxmoxVE/scripts";
        }
        {
          name = "docker hub";
          tags = [
            "docker"
            "homelab"
          ];
          keyword = "docker";
          url = "https://hub.docker.com/";
        }
      ];
    };
  };
}
