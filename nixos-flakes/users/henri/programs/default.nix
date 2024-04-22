{ pkgs, ... }:
{
  imports = [
    ./btop.nix
    ./screenshot.nix
    ./keyboard.nix
    ./keychain.nix
    ./nnn.nix
    ./rofi.nix
    ./printer.nix
    ./plastic_printer.nix
    ./zathura.nix
    ./discord.nix
    ./k9s.nix
    ./fzf.nix
    ./btop.nix
    ./kitty.nix
    ./lazygit.nix
    ./starship.nix
  ];

  # ----------------------
  # default applications
  # ---------------------  
  xdg.mime = {
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "application/json" = [ "vim.desktop" ]; # You'll need a .desktop file for Vim or your preferred editor
      # Video formats
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];
      "video/x-msvideo" = [ "vlc.desktop" ]; # AVI
      "video/webm" = [ "vlc.desktop" ];
      # Directories
      "inode/directory" = [ "thunar.desktop" ];
      # Images
      # "image/jpeg" = [ "feh.desktop" ];
      # "image/png" = [ "feh.desktop" ];
      # "image/gif" = [ "feh.desktop" ];
      # audio
      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];
    };
  };
}
