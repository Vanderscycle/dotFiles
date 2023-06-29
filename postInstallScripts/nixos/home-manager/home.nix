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
  ];
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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
      SUDO_EDITOR = "helix";
      EDITOR = "helix";
      RIPGREP_CONFIG_PATH = "$HOME/.config/rg";
      BROWSER = "firefox";
      TERMINAL = "wezterm";
      NNN_PLUG = "f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed";
      NNN_OPTS = "Hed";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    file = {
      # discord
      ".config/discord/settings.json".source = "${dotfiles_dir}/.config/discord/settings.json";
      # helix
      ".config/helix/config.toml".source = "${dotfiles_dir}/.config/helix/config.toml";
      ".config/helix/languages.toml".source = "${dotfiles_dir}/.config/helix/languages.toml";
      "xprofile" = {
        source = "${dotfiles_dir}/.config/.xprofile";
        target = "./.xprofile";
      };
      # K9s
      ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
      ".config/k9s/skin.yml".source = "${dotfiles_dir}/.config/k9s/skin.yml";
    };
    # of note: do not define a package here and then program.<name>.enable = true; it will cause a conflict
    packages = with pkgs; [
      # languages /fonts
      noto-fonts-emoji
      tldr
      nixpkgs-fmt
      ripgrep
      #terraform
      terraform-ls
      # svelte
      nodePackages.svelte-language-server
      # lua
      lua-language-server
      luajitPackages.luarocks
      luaformatter
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
      # python
      nodePackages.pyright
      poetry
      black
      # go
      gopls
      delve
      # typescript/javascript
      nodePackages.typescript-language-server
      # node
      nodePackages.pnpm
      nodejs
      # shell
      gnupg
      pinentry
      # client
      awscli2
      linode-cli
      # cli
      unzip
      xclip
      zoxide
      xclip
      #3d printing/cad
      super-slicer-latest
      # gui/
      nitrogen
      signal-desktop
      gparted
      vlc
      transmission-gtk
      xfce.thunar
      xfce.thunar-volman
      lxappearance
      insomnia
      slack
      firefox
      # social
      zoom
      discord
      betterdiscordctl
      spotify
      spicetify-cli
      # gaming	
      steam
      flameshot
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
    starship = {
      enable = true;
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
    helix = {
      enable = true;
    };
    go = {
      enable = true;
    };
    };
  xsession = {
    windowManager.awesome.enable = true;
  }; # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

}
