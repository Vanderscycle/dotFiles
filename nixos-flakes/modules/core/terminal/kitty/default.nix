{ username, home-manager, pkgs, ... }:
{
  home-manager.users.${username} = {
    programs = {
      kitty = {
        enable = true;
        theme = "Catppuccin-Mocha";
        shellIntegration.enableFishIntegration = true;
        settings = {
          allow_remote_control = "yes";
          # Add other Kitty settings here if needed
        };
        environment = {
          KITTY_LISTEN_ON = "/tmp/mykitty";
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

