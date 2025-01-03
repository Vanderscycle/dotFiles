{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    kitty.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables kitty shell";
      default = true;
    };
  };

  config = lib.mkIf config.kitty.enable {
    # C-r history
    # C-l clear
    home = {
      sessionVariables = {
        TERMINAL = "kitty";
      };
    };
    programs = {
      kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        shellIntegration.enableZshIntegration = true;
        settings = {
          allow_remote_control = "yes";
          listen_on = "unix:/tmp/kitty";
          disable_ligatures = "never";
        };
        font = {
          size = 16;
          name = "JetBrainsMono";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
      };
    };
    catppuccin.kitty.enable = true;
  };
}
