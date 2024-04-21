{ pkgs, username, ... }:
{

  home-manager.users.${username} = {
    programs.starship =
      # let
      #   flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
      # in
      {
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
        }; # // builtins.fromTOML (builtins.readFile
        # (pkgs.fetchFromGitHub
        #   {
        #     owner = "catppuccin";
        #     repo = "starship";
        #     rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc"; # Replace with the latest commit hash
        #     sha256 = "11pfbly5w5jg44jvgxa8i0h31sqn261l27ahcjibfl5pb9b030dj";
        #   } + /palettes/${flavour}.toml));
      };
  };
}
