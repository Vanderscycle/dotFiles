{ inputs, ... }:
# https://catppuccin.com/palette/
{
  steppe.theming._.catppuccin = flavor: accent: {
    nixos =
      { config, ... }:
      {
        imports = [ inputs.catppuccin.nixosModules.default ];
        catppuccin = {
          enable = true;
          inherit flavor accent;
          # gtk.enable = true;
        };
      };

    homeManager =
      { config, pkgs, ... }:
      {
        imports = [
          inputs.catppuccin.homeModules.catppuccin
          inputs.nix-colors.homeManagerModule
        ];
        catppuccin = {
          enable = true;
          inherit flavor accent;
          bat.enable = config.programs.bat.enable or false;
          btop.enable = config.programs.btop.enable or false;
          fish.enable = config.programs.fish.enable or false;
          nushell.enable = config.programs.nushell.enable or false;
          kitty.enable = config.programs.kitty.enable or false;
          lazygit.enable = config.programs.lazygit.enable or false;

          # gui
          chromium.enable = config.programs.chromium.enable or false;

          vesktop.enable = config.programs.vesktop.enable or false;
          vivaldi.enable = config.programs.chromium.enable or false;
          zathura.enable = config.programs.zathura.enable or false;
          fuzzel.enable = config.programs.fuzzel.enable or false;
          # For Wayland/Desktop components
          waybar.enable = config.programs.waybar.enable or config.services.waybar.enable or false;
          swaync.enable = config.services.swaync.enable or false;
          hyprland.enable = config.wayland.windowManager.hyprland.enable or false;

          # Note: eza/atuin are usually under programs.<name>.enable
          fcitx5.enable = config.i18n.inputMethod.enable or false;
          eza.enable = config.programs.eza.enable or false;
          yazi.enable = config.programs.yazi.enable or false;
          television.enable = config.programs.television.enable or false;
          mangohud.enable = config.programs.mangohud.enable or false;
          broot.enable = config.programs.broot.enable or false;
          atuin.enable = config.programs.atuin.enable or false;
          starship.enable = config.programs.starship.enable or false;
          fzf.enable = config.programs.fzf.enable or false;
        };
        colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
      };
  };
}
