{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.kitty.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables kitty shell";
      default = true;
    };
  };

  config = lib.mkIf config.program.kitty.enable {
    # C-r history
    # C-l clear
    home = {
      sessionVariables = {
        TERMINAL = "kitty";
      };
    };
    programs = {
      kitty = {
        package = pkgs.kitty.overrideAttrs (oldAttrs: {
          # https://github.com/NixOS/nixpkgs/issues/388020
          doInstallCheck = false;
        });
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
          name = "JetBrains Mono";
          package = pkgs.nerd-fonts.jetbrains-mono;
        };
      };
    };
    catppuccin.kitty.enable = true;
  };
}
