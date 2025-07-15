{ pkgs, ... }:
{

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
        name = "JetBrainsMono";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
  };
}
