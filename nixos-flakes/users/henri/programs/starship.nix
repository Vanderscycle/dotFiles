{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    programs.starship = {
      enable = true;
      catppuccin.enable = true;
      enableFishIntegration = true;
      settings = {
        aws = {
          format = "on [$symbol($profile )(\($region\) )]($style)";
          style = "bold blue";
          symbol = "🅰 ";
        };

        kubernetes = {
          format = "on [⛵ $context ](dimmed green) ";
          disabled = false;
        };

        terraform = {
          format = "[💨 $version$workspace]($style) ";
        };
        battery = {
          full_symbol = "🔋 ";
          charging_symbol = "⚡️ ";
          discharging_symbol = "💀 ";
          display = {
            threshold = 30;
            style = "bold red";
          };
        };

        format = "$all"; # Remove this line to disable the default prompt format
        # palette = "catppuccin_${flavour}";
      };
    };
  };
}
