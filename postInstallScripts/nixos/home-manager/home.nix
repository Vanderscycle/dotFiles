# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;

in
{
  # You can import other home-manager modules here
  imports = [
    ./modules/services
    ./modules/programs
    ./modules/languages
    ./unstable-packages.nix
  ];
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # https://github.com/NixOS/nixpkgs/issues/157101
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };
  home = {
    username = "henri";
    homeDirectory = "/home/henri";
    sessionVariables = {
      GTK_IM_MODULE="fcitx5";
      QT_IM_MODULE="fcitx5";
      XMODIFIERS="@im=fcitx5";
      XIM="fcitx5";
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "Sway";
      QT_QPA_PLATFORM = "wayland";
      SUDO_EDITOR = "nvim";
      EDITOR = "hx";
      RIPGREP_CONFIG_PATH = "$HOME/.config/rg";
      BROWSER = "firefox";
      TERMINAL = "wezterm";
      NNN_PLUG = "f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed";
      NNN_OPTS = "Hed";
      NNN_TMPFILE = "/tmp/nnn";
      NNN_FIFO = "/tmp/nnn.fifo";
      TLDR_AUTO_UPDATE_DISABLED = "false";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    file = {
      ".config/neofetch/config.conf".source = "${dotfiles_dir}/.config/neofetch/config.conf";
      "xprofile" = {
        source = "${dotfiles_dir}/.config/.xprofile";
        target = "./.xprofile";
      };
    };
    # of note: do not define a package here and then program.<name>.enable = true; it will cause a conflict
    packages = with pkgs; [
      nitrogen
      # TODO: mv to awesome.nix
      #battery
      acpi
      # auto mount drives
      udisks
      udiskie
      flameshot
      # wifi
      # nmcli
      # languages /fonts
      noto-fonts-emoji
      tldr
      nixpkgs-fmt
      #terraform
      terraform-ls
      # toml
      taplo
      # yaml
      nodePackages.yaml-language-server
      # json
      nodePackages.vscode-json-languageserver
      # nix
      nil
      # bash
      nodePackages.bash-language-server
      shellcheck
      # editing (3d/photos)
      shotwell
      # shell
      gnupg
      pinentry
      # client
      rclone
      awscli2
      linode-cli
      # cli
      unzip
      xclip
      zoxide
      xclip
      #3d printing/cad
      super-slicer-latest
      #keyboard
      wally-cli
      # gui/
      slides # terminal based powerpoint
      onlyoffice-bin # word/excel/etc
      rpi-imager
      neofetch
      signal-desktop
      gparted
      vlc
      transmission-gtk
      xfce.thunar
      xfce.thunar-volman
      insomnia
      slack
      pulseaudioFull
      firefox
      # social
      zoom
      # nix
      nix-prefetch-git
      # nfs 
      nfs-utils
      # ssh
      sshpass
    ];
  };
  services = {
    gpg-agent = {
      enableSshSupport = true;
    };
  };
  programs = {
    gpg = {
      enable = true;
    };
    ssh = {
      #     enable = true;
      includes = [ "$HOME/.ssh/endeavourGit" ];
    };
    keychain = {
      enable = true;
      keys = [ "$HOME/.ssh/endeavourGit" ];
    };
    home-manager = {
      enable = true;
    };
    rofi = {
      enable = true;
    };
  };
  xsession = {
    windowManager.awesome.enable = true;
  }; # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

}
