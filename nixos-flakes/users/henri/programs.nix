{ pkgs, hostname, ... }:
{
  imports = [
    ../../modules/programs/devops.nix
    ../../modules/programs/multimedia.nix
    ../../modules/programs/libreoffice.nix
    ../../modules/programs/cloud
    ../../modules/programs/thunar
    ../../modules/programs/orca_slicer.nix
    ../../modules/programs/btop.nix
    ../../modules/programs/ventoy.nix
    ../../modules/programs/screenshot.nix
    ../../modules/programs/keyboard.nix
    ../../modules/programs/keychain.nix
    ../../modules/programs/nnn.nix
    ../../modules/programs/printer.nix
    ../../modules/programs/plastic_printer.nix
    ../../modules/programs/zathura.nix
    ../../modules/programs/discord.nix
    ../../modules/programs/k9s.nix
    ../../modules/programs/fzf.nix
    ../../modules/programs/btop.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/lazygit.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/bat.nix
    ../../modules/programs/rg.nix
    ../../modules/programs/signal.nix
    ../../modules/programs/lf
    ../../modules/programs/work.nix
    ../../modules/programs/spicetify.nix
    ../../modules/programs/rpi-imager.nix
    ../../modules/programs/firefox.nix

  ] ++ (if hostname == "desktop" then [ ../../modules/programs/fuzzel.nix ] else [ ]);
  # ----------------------
  # default applications
  # ---------------------
  # xdg-mime query filetype <file>
  xdg.mime = {
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "application/json" = [ "nvim.desktop" ]; # You'll need a .desktop file for Vim or your preferred editor
      "text/plain" = [ "nvim.desktop" ];
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
  # emacs
  environment.systemPackages = with pkgs; [
    texliveFull # latex client
    emacs-all-the-icons-fonts
    libtool
    sqlite
    cmake
    gcc
  ];
}
