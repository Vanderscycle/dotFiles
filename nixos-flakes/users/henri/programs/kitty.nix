{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      kitty = {
        enable = true;
        catppuccin.enable = true;
        shellIntegration.enableFishIntegration = true;
        settings = {
          allow_remote_control = "yes";
          listen_on = "unix:/tmp/mykitty";
          # Add other Kitty settings here if needed
          # "alt+h" = "left";
          # "alt+j" = "own";
          # "alt+k" = "up";
          # "alt+l" = "right";
        };
        font = {
          size = 14;
          name = "JetBrainsMono";
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        };
      };
    };
  };
}
