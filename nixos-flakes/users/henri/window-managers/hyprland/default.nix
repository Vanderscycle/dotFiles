{
  username,
  home-manager,
  pkgs,
  ...
}:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home-manager.users.${username} = {
    home = {
      file = {
        ".config/hypr/hyprland.conf".source = "${dotfiles_dir}/.config/hypr/hyprland.conf";
        ".config/hypr/mocha.conf".source = "${dotfiles_dir}/.config/hypr/mocha.conf";
        ".config/hypr/start.sh".source = "${dotfiles_dir}/.config/hypr/start.sh";
      };

      packages = with pkgs; [
        swww
        xdg-desktop-portal-hyprland
        wl-clipboard
        xdg-desktop-portal-hyprland
      ];
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };
    wayland.windowManager = {
      sway = {
        enable = true;
      };
      hyprland = {
        enable = true;
      };
    };
  };
}
