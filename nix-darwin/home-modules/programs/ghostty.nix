{
  lib,
  config,
  ...
}:
{
  options = {
    program.ghostty.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables ghostty shell";
      default = true;
    };
  };

  config = lib.mkIf config.program.ghostty.enable {
    home = {
      sessionVariables = {
        # TERMINAL = "kitty";
      };
    };
    programs = {
      ghostty = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          font-size = 16;
          font-family = "JetBrainsMono";
        };
      };
    };
  };
}
