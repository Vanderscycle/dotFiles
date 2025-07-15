{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    proton.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the proton services";
      default = true;
    };
  };

  config = lib.mkIf config.proton.enable {
    home = {
      packages = with pkgs; [
        proton-pass
        protonmail-bridge # for email
        pass-wayland
        protonvpn-gui
      ];
    };
  };
}
