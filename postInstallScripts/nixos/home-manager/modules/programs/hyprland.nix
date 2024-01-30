{ nixpkgs, config, pkgs, unstable, ... }:
{
  home = {
    packages = with pkgs; [
      sway
      swww
      xdg-desktop-portal-hyprland
      wl-clipboard
    ];
    file = {
      ".config/hypr/hyprland.conf".source = "${dotfiles_dir}/.config/hypr/hyprland.conf";
      ".config/hypr/mocha.conf".source = "${dotfiles_dir}/.config/hypr/mocha.conf";
      ".config/hypr/start.sh".source = "${dotfiles_dir}/.config/hypr/start.sh";
    };
  };
}
