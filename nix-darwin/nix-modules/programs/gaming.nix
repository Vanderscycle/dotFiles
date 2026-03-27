{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    program.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables linux best program.gaming";
      default = false;
    };

    program.gaming.mangohud.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables mangohud";
      default = false;
    };
  };
  config = lib.mkIf config.program.gaming.enable {
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
      ++ (if config.program.gaming.mangohud.enable then [ mangohud ] else [ ]);
  };
}
