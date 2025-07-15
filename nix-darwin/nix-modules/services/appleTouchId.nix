{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    apple.touchId.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables apple's touchId";
      default = false;
    };
  };
  config = lib.mkIf config.apple.touchId.enable {
    #https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050#file-flake-nix-L144
    security.pam.enableSudoTouchIdAuth = ''
      Enable sudo authentication with Touch ID
      When enabled, this option adds the following line to /etc/pam.d/sudo:
          auth       sufficient     pam_tid.so
      (Note that macOS resets this file when doing a system update. As such, sudo
      authentication with Touch ID won't work after a system update until the nix-darwin
      configuration is reapplied.)
    '';
  };
}
