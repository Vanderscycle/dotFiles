{
  username,
  home-manager,
  pkgs,
  ...
}:
let
  dotfiles_dir = /home/${username}/Documents/dotFiles;
in

{
  environment.systemPackages = [ pkgs.webcord-vencord ];

  #  nix run nixpkgs#betterdiscordctl install
  home-manager.users.${username} = {
    home = {
      file.".config/discord/settings.json" = {
        source = "${dotfiles_dir}/.config/discord/settings.json";
      };
      packages = with pkgs; [ discord ];
    };
  };
}
