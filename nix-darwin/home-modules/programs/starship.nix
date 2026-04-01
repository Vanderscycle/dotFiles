{
  lib,
  config,
  ...
}:
{
  options = {
    program.starship.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the best cli";
      default = true;
    };
  };

  config = lib.mkIf config.program.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = config.program.fish.enable;
      enableZshIntegration = config.program.zsh.enable;
      enableNushellIntegration = true;
      # https://starship.rs/config/
      settings = {
        aws = {
          format = "on [$symbol($profile )(($region) )]($style)";
          style = "bold blue";
          symbol = "🅰 ";
        };
        kubernetes = {
          format = "on [⛵ $context ](dimmed green) ";
          disabled = false;
        };

        sudo = {
          disabled = false;
        };
        terraform = {
          format = "[💨 $version$workspace]($style) ";
        };
        # battery = {
        #   full_symbol = "🔋 ";
        #   charging_symbol = "⚡️ ";
        #   discharging_symbol = "💀 ";
        #   display = {
        #     threshold = 30;
        #     style = "bold red";
        #   };
        # };
        format = "$all"; # Remove this line to disable the default prompt format
      };
    };
    catppuccin.starship.enable = true;
  };
}
