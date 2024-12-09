{ pkgs, ... }:
{
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
      catppuccin.enable = true;
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
