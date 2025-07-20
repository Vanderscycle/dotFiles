{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.modern_unix.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables better unix commands";
      default = true;
    };
  };

  config = lib.mkIf config.program.modern_unix.enable {
    home.packages = with pkgs; [
      hyperfine # how xz was discovered
      curlie # curl + httpie baby
      unzip
      silver-searcher # ag
      platinum-searcher # pt
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
      broot.enable = true;
    };
  };
}
