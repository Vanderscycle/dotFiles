{
  pkgs,
  ...
}:
let
  dotfiles_dir = ~/Documents/dotFiles;
in

{
  environment.systemPackages = [ pkgs.webcord-vencord ];

  #  nix run nixpkgs#betterdiscordctl install
  home = {
    # file.".config/discord/settings.json" = {
    #   source = "${dotfiles_dir}/.config/discord/settings.json";
    # };
    packages = with pkgs; [ discord ];
  };
}
