{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    modern_unix.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables better unix commands";
      default = true;
    };
  };

  config = lib.mkIf config.modern_unix.enable {
    home.packages = with pkgs; [
      hyperfine # how xz was discovered
      curlie # curl + httpie baby
    ];
    programs = {
      eza = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
      jq.enable = true;
      fd.enable = true;
      ripgrep.enable = true;
    };
  };
}
