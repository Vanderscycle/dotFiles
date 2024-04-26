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
        catppuccin.enable = true;
        enable = true;
      };
    };
  };
}
