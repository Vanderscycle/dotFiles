{ ... }:
{
  steppe.gaming = {
    nixos =
      { pkgs, ... }:
      {
        boot.kernelModules = [ "ntsync" ];
        environment.systemPackages = with pkgs; [
          # Launchers
          cartridges
          heroic
          lutris
          starsector
          augustus # caesar 3 mod
          innoextract # for caesar 3
          # (lutris.override {
          #   extraPkgs = _: [ umu-launcher ];
          # })
          umu-launcher
        ];
        hardware.graphics.enable32Bit = true;
        programs = {
          steam = {
            enable = true;
            extraCompatPackages = with pkgs; [
              proton-ge-bin
              steamtinkerlaunch
            ];
          };
          gamescope = {
            enable = true;
            args = [
              # "-W ${toString host.primaryDisplay.width}"
              # "-H ${toString host.primaryDisplay.height}"
              # "-r ${toString host.primaryDisplay.refresh}"
              # "-O ${host.primaryDisplay.name}"
              "-f"
              "--adaptive-sync"
              "--mangoapp"
            ];
          };
        };
      };
    homeManager = {
      programs = {
        mangohud = {
          enable = true;
        };
      };
    };
  };
}
