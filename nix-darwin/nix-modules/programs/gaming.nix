{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables linux best gaming";
      default = false;
    };

    gaming.mangohud.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables mangohud";
      default = false;
    };
  };
  config = lib.mkIf config.gaming.enable {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
      ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    environment.systemPackages =
      with pkgs;
      [
        starsector
        gamescope
        augustus # caesar 3 mod
        innoextract # for caesar 3
      ]
      ++ (if config.gaming.mangohud.enable then [ mangohud ] else [ ]);
  };
}
