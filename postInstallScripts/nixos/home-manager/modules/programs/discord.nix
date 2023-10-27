{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    file = {
      # discord
      ".config/discord/settings.json".source = "${dotfiles_dir}/.config/discord/settings.json";
      # discocss
      # ".config/discocss/custom.css".source = "${dotfiles_dir}/.config/discocss/custom.css";
      # betterdiscordctl
      ".config/BetterDiscord/themes/mocha.theme.css".source = "${dotfiles_dir}/.config/betterdiscord/mocha.theme.css";
    };
    packages = with pkgs; [
      discord
      betterdiscordctl
      # discocss
    ];
  };
}
