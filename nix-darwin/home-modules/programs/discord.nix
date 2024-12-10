{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    discord.enable = lib.mkEnableOption "enables discord";
  };

  # let
  #   dotfiles_dir = ~/Documents/dotFiles;
  # in

  config = lib.mkIf config.discord.enable {
    #  nix run nixpkgs#betterdiscordctl install
    home = {
      # file.".config/discord/settings.json" = {
      #   source = "${dotfiles_dir}/.config/discord/settings.json";
      # };
      packages = with pkgs; [ discord ];
    };
  };
}
