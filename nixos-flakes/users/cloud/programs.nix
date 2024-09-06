{ pkgs, ... }:
{
  imports = [
    ../../modules/programs/devops.nix
    ../../modules/programs/btop.nix
    ../../modules/programs/keychain.nix
    ../../modules/programs/nnn.nix
    ../../modules/programs/zathura.nix
    ../../modules/programs/k9s.nix
    ../../modules/programs/fzf.nix
    ../../modules/programs/btop.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/lazygit.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/bat.nix
    ../../modules/programs/rg.nix
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