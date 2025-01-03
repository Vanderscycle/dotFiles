{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    alacritty.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables alacritty shell";
      default = false;
    };
  };

  config = lib.mkIf config.alacritty.enable {
    # C-r history
    # C-l clear
    home = {
      sessionVariables = {
        TERMINAL = "alacritty";
      };
    };
    programs = {
      alacritty = {
        enable = true;
        catppuccin.enable = true;
        shellIntegration.enableFishIntegration = true;
        shellIntegration.enableZshIntegration = true;
        font = {
          size = 16;
          name = "JetBrainsMono";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
      };
    };
  };
}
